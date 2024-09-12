class_name EnemyAttackBase
extends Area2D

@export var hitbox: CollisionShape2D

var right_facing_transform: Transform2D = Transform2D()
var left_facing_transform: Transform2D = Transform2D()

var damage: int = 0

func _enter_tree() -> void:
	right_facing_transform = transform
	left_facing_transform = transform * Transform2D.FLIP_X
	left_facing_transform.origin.x *= -1

func SetOrientation(facing_right: bool) -> void:
	if facing_right:
		transform = right_facing_transform
	else:
		transform = left_facing_transform

func SetEnable(enable: bool) -> void:
	hitbox.set_deferred("disabled", not enable)
