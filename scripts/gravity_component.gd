class_name GravityComponent
extends Node2D

@export_subgroup("Settings")
@export var gravity: float = 1100.0
var airdash: bool = false
var is_falling: bool = false
var homing: bool = false


func HandleGravity(body: CharacterBody2D, suit_air_mov: bool, delta: float) -> void:
	if not body.is_on_floor() and not suit_air_mov:
		body.velocity.y += gravity * delta
		is_falling = true
	elif body.is_on_floor():
		is_falling = false
