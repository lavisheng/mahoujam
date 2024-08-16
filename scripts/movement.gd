class_name MovementComponent
extends Node

@export_subgroup("Setting")
@export var speed: float = 100
@export var air_control: bool = false

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	if air_control or body.is_on_floor():
		body.velocity.x = direction * speed;
