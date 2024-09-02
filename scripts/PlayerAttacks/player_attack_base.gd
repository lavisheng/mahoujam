class_name PlayerAttackBase
extends Area2D
const FRAME = 1. / 60.
#enum MOVE_STATE {startup, active, recovery, rest}
@export_group("Move Settings")
@export var startup_frames: int = 0
@export var active_frames: int = 0
@export var recovery_frames: int = 0
@export var cancellable: bool = true
@export_subgroup("Nodes")
@export var hitbox: CollisionShape2D

var state: int = Global.MOVE_STATE.rest
var right_facing_transform: Transform2D = Transform2D()
var left_facing_transform: Transform2D = Transform2D()
#var timer: float = 0.


func _ready() -> void:
	# LETS PRECALCULATE THE FLIPPED TRANSFORM
	right_facing_transform = transform
	left_facing_transform = transform * Transform2D.FLIP_X


## Converts "accumulated" state to float which returns the total amount of time
## since start of the move initiating till the start of given state.
## ie. active would give you startup_frames time and recovery would be startup + active times
func ConvertAccStateToFloat(state: int) -> float:
	match state:
		Global.MOVE_STATE.startup:
			return 0
		Global.MOVE_STATE.active:
			return startup_frames * FRAME
		Global.MOVE_STATE.recovery:
			return (startup_frames + active_frames) * FRAME
		Global.MOVE_STATE.rest:
			return (startup_frames + active_frames + recovery_frames) * FRAME
		_:
			print("Error, invalid move state")
	return -1


func UpdateCurrentState(timer: float) -> void:
	var updated_state = state
	for s in range(state, Global.MOVE_STATE.rest + 1):
		if timer > ConvertAccStateToFloat(s):
			updated_state = s
	state = updated_state


func HandleState(timer: float) -> void:
	UpdateCurrentState(timer)
	if state == Global.MOVE_STATE.active:
		hitbox.set_deferred("disabled", false)
	else:
		hitbox.set_deferred("disabled", true)
