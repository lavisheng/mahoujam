class_name PlayerHurtbox
extends Area2D

var player: Player


func _enter_tree() -> void:
	player = get_parent()


func HitPlayer(damage: int) -> void:
	pass
