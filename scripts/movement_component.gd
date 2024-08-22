class_name MovementComponent
extends Node2D
@export var gravity_component: GravityComponent
@export_subgroup("Settings")
@export var ground_speed: float = 100
@export var air_speed: float = 2000
@export var homing_speed: float = 250
const NUM_AIRDASHES = 2
const NUM_HOMING = 1
var num_airdashes: int = NUM_AIRDASHES
var num_homing: int = NUM_HOMING
var airdash_delta: float = .75
var homing_delta: float = 2.
var is_jumping: bool = false
var jump_velocity: float = -350.0


func handle_jump(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
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


func handle_air_dash(body: CharacterBody2D, direction: float, delta: float) -> void:
	if not body.is_on_floor() and direction != 0 and num_airdashes > 0:
		body.velocity.x = direction * air_speed
		gravity_component.airdash = true
		body.velocity.y = 0
		num_airdashes -= 1
		airdash_delta = .75
	elif gravity_component.airdash and airdash_delta > 0:
		airdash_delta -= delta
		body.velocity.x *= airdash_delta * airdash_delta * airdash_delta
		if abs(body.velocity.x) <= 0.05:
			gravity_component.airdash = false


func landed(body: CharacterBody2D) -> void:
	if body.is_on_floor():
		body.transform = body.transform.looking_at(body.transform.get_origin() + Vector2(1.0, 0.0))
		#num_airdashes = NUM_AIRDASHES
		#num_homing = NUM_HOMING
		#homing_delta = 2.
		#gravity_component.homing = false


func handle_homing_dash(
	body: CharacterBody2D, target: Transform2D, delta: float, event: bool
) -> void:
	if event and not gravity_component.airdash and gravity_component.is_falling and num_homing > 0:
		print("HOMING")
		gravity_component.homing = true
		num_homing -= 1
	if (
		gravity_component.homing
		and body.transform.get_origin().distance_to(target.get_origin()) < 1
	):
		body.velocity = Vector2(0, 0)
		gravity_component.homing = false
		homing_delta = 2.
	elif gravity_component.homing and homing_delta > 0:
		body.transform = body.transform.looking_at(target.get_origin())
		body.velocity.x = homing_speed * cos(body.transform.get_rotation())
		body.velocity.y = homing_speed * sin(body.transform.get_rotation())
		homing_delta -= delta
	else:
		homing_delta = 2.
		gravity_component.homing = false
