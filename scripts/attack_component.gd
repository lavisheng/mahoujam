class_name AttackComponent
extends Node

@export_subgroup("Settings")
@export var active_len: float = 0.2
@export var damage: int = 2
@export var hitstop: float = 0.1

@export_subgroup("Nodes")
@export var left_hitbox: CollisionShape2D
@export var right_hitbox: CollisionShape2D

@onready var attacker = get_parent()

var is_attacking: bool = false
var attack_delta: float = 0.


func HandleAttack(body: CharacterBody2D, want_to_attack: bool, facing_right: bool) -> void:
	if not want_to_attack:
		return
	if is_attacking or (attacker.hitstop_delta > 0):
		return
	is_attacking = true
	attack_delta = active_len
	right_hitbox.disabled = !facing_right
	left_hitbox.disabled = facing_right


func _physics_process(delta: float):
	attack_delta = clamp(attack_delta - delta, 0, active_len)
	if is_attacking and (attack_delta <= 0):
		right_hitbox.disabled = true
		left_hitbox.disabled = true

	is_attacking = attack_delta > 0


func _on_body_entered(body):
	body.HandleAttack(damage)
	body.hitstop_delta = hitstop
	attacker.hitstop_delta = hitstop
