class_name AttackComponent
extends Node

@export_subgroup("Settings")
@export var active_len: float = 0.2
@export var damage: int = 2
@export var hitstop: float = 0.1

@export_subgroup("Nodes")
#@export var left_hitbox: CollisionShape2D
#@export var right_hitbox: CollisionShape2D

@export_subgroup("Moves")
@export var ground_launch: PlayerAttackBase
@export var air_one: PlayerAttackBase
@export var air_two: PlayerAttackBase

var curr: PlayerAttackBase = PlayerAttackBase.new()

@onready var attacker = get_parent()

var is_attacking: bool = false
var attack_delta: float = 0.

var timer: float = 0.


func HandleAttack(player: Player) -> void:
	if curr.state == Global.MOVE_STATE.rest:
		print("lol state")
		# todo: select curr correctly
		if player.is_on_floor():
			curr = ground_launch
		#elif curr == air_one and curr.state == Global.MOVE_STATE.recovery:
		#	curr = air_two
		else:
			curr = air_one
		curr.SetOrientation(player.facing_right)
		curr.state = Global.MOVE_STATE.startup
		timer = 0.
	elif curr.state >= Global.MOVE_STATE.recovery:
		if curr == air_one:
			curr = air_two
			curr.SetOrientation(player.facing_right)
			curr.state = Global.MOVE_STATE.startup
			timer = 0.

	#if is_attacking or (attacker.hitstop_delta > 0):
	#	return
	#is_attacking = true
	#attack_delta = active_len
	#right_hitbox.disabled = !facing_right
	#left_hitbox.disabled = facing_right


func _physics_process(delta: float):
	timer += delta
	if curr.state != Global.MOVE_STATE.rest:
		curr.HandleState(timer)
	#attack_delta = clamp(attack_delta - delta, 0, active_len)
	#if is_attacking and (attack_delta <= 0):
	#	right_hitbox.disabled = true
	#	left_hitbox.disabled = true

	#is_attacking = attack_delta > 0

#func _on_body_entered(body):
#	body.HandleAttack(damage)
#	body.hitstop_delta = hitstop
#	attacker.hitstop_delta = hitstop
