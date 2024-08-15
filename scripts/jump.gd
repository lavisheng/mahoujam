class_name JumpComponent
extends Node

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0
@export var max_jumps: int = 2

var is_jumping: bool = false
var jumps_left: int = max_jumps

func handle_jump(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and jumps_left > 0:
		body.velocity.y = jump_velocity
		jumps_left -= 1
	elif body.is_on_floor():  ## placement feels weird
		jumps_left = max_jumps
		
	is_jumping = body.velocity.y < 0 and not body.is_on_floor()
	
