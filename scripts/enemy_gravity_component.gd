class_name EnemyGravityComponent
extends Node2D

@export_subgroup("Settings")
@export var gravity: float = 1100.0


func HandleGravity(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
	#print(body.is_on_floor())
