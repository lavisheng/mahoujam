class_name MovementComponent
extends Node2D
@export var gravity_component: GravityComponent
@export_subgroup("Settings")
@export var ground_speed: float = 100
@export var held_jump_time: float = 0.2
@export var jump_velocity: float = -350.0
var is_jumping: bool = false
var jump_held: float = 0
var jump_start_done: bool = false

func SetJumpStartDone() -> void:
	print("DONE")
	jump_start_done = true

func HandleJump(player: Player, want_to_jump: bool, modifier: float, delta: float) -> void:
	if jump_start_done:
		player.velocity.y = jump_velocity * modifier
		jump_held = held_jump_time
		player.SetAnimation("Jumping")
		jump_start_done = false
	elif want_to_jump and jump_held > 0:
		jump_held -= delta
		player.velocity.y = jump_velocity * modifier
	elif want_to_jump and player.is_on_floor() and player.animation_player.current_animation != "JumpStart":
		print("%s" % player.animation_player.current_animation)
		player.SetAnimation("JumpStart")
		jump_start_done = false
	elif not player.is_on_floor():
		jump_held = -1
	is_jumping = player.velocity.y < 0 and not player.is_on_floor()

	if player.animation_player.current_animation == "FallStart" and player.animation_player.current_animation_position / player.animation_player.current_animation_length > 0.9:
		player.SetAnimation("Fall")
	elif not player.is_on_floor() and not is_jumping and player.active_suit.air_movement == false:
		player.SetAnimation("FallStart")


func HandleHorizontalMovement(
	body: Player, direction: float, speedDelta: float, multiplier: float
) -> void:
	if not gravity_component.is_falling:
		body.velocity.x = direction * (ground_speed + speedDelta) * multiplier
		if direction:
			var prev_facing_right: bool = body.facing_right
			body.facing_right = sign(direction) == 1
			if (prev_facing_right != body.facing_right and body.animation_player.current_animation == "Run") or body.animation_player.current_animation == "Idle":
				body.SetAnimation("Run")
		elif body.animation_player.current_animation == "Run":
			body.SetAnimation("Idle")
	
func HandleAirMovement(
	body: CharacterBody2D, direction: float, speedDelta: float, multiplier: float
) -> void:
	if gravity_component.is_falling:
		body.velocity.x = direction * (ground_speed + speedDelta) * multiplier
		if direction:
			body.facing_right = sign(direction) == 1


func Landed(body: Player) -> void:
	if body.is_on_floor():
		body.transform = body.transform.looking_at(body.transform.get_origin() + Vector2(1.0, 0.0))
		if body.animation_player.get_current_animation() == "FallStart":
			body.SetAnimation("Land")
