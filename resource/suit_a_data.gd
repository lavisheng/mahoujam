#extends "res://resource/suit_data.gd"

class_name Suit_a extends SuitData

@export var giga_jump_vel: float = -700

@export_subgroup("Settings")
const NUM_HOMING = 1
var num_homing: int = NUM_HOMING
@export var homing_speed: float = 200
@export var homing_delta: float = .75
const HOVER_TIME = 4.
@export var hover_time: float = 0.0
const OFFSET = [Vector2(-17, 0), Vector2(0, -17), Vector2(17, 0)]
var bullets = [-1, -1, -1]
var shoot_index: int = 3
var homing_target = null


func SuitAbilityCallback(player: Player):
	if player.input_component.GetSpecialInput() and not player.is_on_floor() and shoot_index == 3:
		print("I'm an overloaded suit a")
		hover_time = HOVER_TIME
		shoot_index = 0
		for i in range(3):
			bullets[i] = load("res://scenes/components/suite_a_bullet.tscn").instantiate()
			bullets[i].transform = bullets[i].transform.translated(
				player.transform.get_origin() + OFFSET[i]
			)
			player.get_parent().add_child(bullets[i])
			bullets[i].SetDirection(player.facing_right)
			bullets[i].hit_target.connect(AssignHomingTarget)
		player.velocity = Vector2(0, 0)


func SuitCollisionCallback(player: Player) -> void:
	# if collide with anything turn off the air movement
	air_movement = false


func AssignHomingTarget(hit_target: Transform2D) -> void:
	homing_target = hit_target


func HandleHomingDash(player: Player, target: Transform2D, delta: float) -> void:
	if (
		player.input_component.GetHomingInput()
		and not air_movement
		and player.gravity_component.is_falling
		and num_homing > 0
	):
		print("HOMING")
		air_movement = true
		num_homing -= 1
		while shoot_index < 3:
			bullets[shoot_index].queue_free()
			shoot_index += 1
	if air_movement and player.transform.get_origin().distance_to(target.get_origin()) < 1:
		player.velocity = Vector2(0, 0)
		air_movement = false
		homing_delta = 2.
	elif air_movement and homing_delta > 0:
		player.transform = player.transform.looking_at(target.get_origin())
		player.velocity.x = homing_speed * cos(player.transform.get_rotation())
		player.velocity.y = homing_speed * sin(player.transform.get_rotation())
		homing_delta -= delta
	else:
		homing_delta = 2.
		air_movement = false


func SuitAbilityProcess(player: Player, delta: float):
	if hover_time > 0 and shoot_index < 3:
		hover_time -= delta
		player.velocity.y = 0
		if player.input_component.GetSpecialInput():
			bullets[shoot_index].FireBullet(player.input_component.GetMousePosition())
			shoot_index += 1
	if homing_target != null:
		HandleHomingDash(player, homing_target, delta)
