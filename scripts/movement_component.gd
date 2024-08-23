class_name MovementComponent
extends Node2D
@export var gravity_component: GravityComponent
@export_subgroup("Settings")
@export var ground_speed: float = 100
@export var held_jump_time: float = 0.2
@export var jump_velocity: float = -250.0
var is_jumping: bool = false
var jump_held: float = 0


func handle_jump(body: CharacterBody2D, want_to_jump: bool, modifier: float, delta: float) -> void:
	if want_to_jump and body.is_on_floor():
		print("JUMP INIT")
		body.velocity.y = jump_velocity * modifier
		jump_held = held_jump_time
	elif want_to_jump and jump_held > 0:
		print("JUMP HELD")
		jump_held -= delta
		body.velocity.y = jump_velocity * modifier
	elif not body.is_on_floor():
		print("JUMP NOT")
		jump_held = -1
	is_jumping = body.velocity.y < 0 and not body.is_on_floor()


func handle_horizontal_movement(
	body: CharacterBody2D, direction: float, speedDelta: float, multiplier: float
) -> void:
	if not gravity_component.is_falling:
		body.velocity.x = direction * (ground_speed + speedDelta) * multiplier


func handle_air_movement(
	body: CharacterBody2D, direction: float, speedDelta: float, multiplier: float
) -> void:
	if gravity_component.is_falling:
		body.velocity.x = direction * (ground_speed + speedDelta) * multiplier


func landed(body: CharacterBody2D) -> void:
	if body.is_on_floor():
		body.transform = body.transform.looking_at(body.transform.get_origin() + Vector2(1.0, 0.0))
