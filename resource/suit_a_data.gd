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
var shoot_index = 3
# DEBUG FOR HOMING YET TO BE IMPLEMENTED WITH THE FULL TARGETING SYSTEM
# FOR THIS SUIT'S SPECIAL
var debug_bullets = 1
var debug_bullet = null

func FireDebugBullet(body: CharacterBody2D):
    if debug_bullets > 0:
        debug_bullet = load("res://scenes/player_bullet.tscn").instantiate()
        debug_bullet.transform = debug_bullet.transform.translated(body.transform.get_origin())
        body.get_parent().add_child(debug_bullet)
        debug_bullets -= 1

func SuitAbilityCallback(player: Player):
    if player.input_component.get_special_input() and not player.is_on_floor() and shoot_index == 3:
        print("I'm an overloaded suit a");
        hover_time = HOVER_TIME
        shoot_index = 0
        for i in range(3):
            bullets[i] = load("res://scenes/components/suite_a_bullet.tscn").instantiate()
            bullets[i].transform = bullets[i].transform.translated(
                player.transform.get_origin() + OFFSET[i]
            )
            player.get_parent().add_child(bullets[i])
        player.velocity = Vector2(0, 0)
    #do a giga jump ( of hell )
    #if wantInput and body.is_on_floor():
    #    body.velocity.y = giga_jump_vel

func handle_homing_dash(
    player: Player, target: Transform2D, delta: float) -> void:
    if (
        player.input_component.get_homing_input() 
        and not air_movement
        and player.gravity_component.is_falling
        and num_homing > 0
        ):
        print("HOMING")
        air_movement = true
        num_homing -= 1
    if (
        air_movement
        and debug_bullet
        and player.transform.get_origin().distance_to(target.get_origin()) < 1
    ):
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
func landed(body: CharacterBody2D) -> void:
    if body.is_on_floor():
        air_movement = false
        num_homing = NUM_HOMING
        homing_delta = 2.

func SuitAbilityProcess(player: Player, delta: float):
    if hover_time > 0 and shoot_index < 3:
        hover_time -= delta
        player.velocity.y = 0
        if player.input_component.get_special_input():
            bullets[shoot_index].fire_bullet()
            shoot_index += 1
