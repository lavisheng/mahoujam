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
@export var suit_b_special: PlayerAttackBase

var curr: PlayerAttackBase = PlayerAttackBase.new()

@onready var attacker = get_parent()

var is_attacking: bool = false
var attack_delta: float = 0.

var timer: float = 0.


func HandleAttack(player: Player) -> void:
	if curr.state == Global.MOVE_STATE.rest:
		if player.is_on_floor():
			curr = ground_launch
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

func SuitBSpecial(orientation: bool) -> bool:
	if curr.state == Global.MOVE_STATE.rest or curr.cancellable:
		curr = suit_b_special
		curr.SetOrientation(orientation)
		curr.state = Global.MOVE_STATE.startup
		timer = 0.
		return true
	return false


func _physics_process(delta: float):
	timer += delta
	if curr.state != Global.MOVE_STATE.rest:
		curr.HandleState(timer)
