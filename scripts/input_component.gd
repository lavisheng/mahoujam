class_name InputComponent
extends Node2D

signal attack_signal

var input_horizontal: float = 0.0
const DOUBLETAP_DELAY = .25
var doubletap_time = DOUBLETAP_DELAY
var last_action = ""
var input_doubletap: float = 0.0
var mouse_position: Vector2 = Vector2(0, 0)


func _input(event):
	if event is InputEventKey:
		if event.is_pressed():
			for e in [[&"move_left", -1], [&"move_right", 1]]:
				if Input.is_action_just_pressed(e[0]):
					input_horizontal = e[1]
					if last_action == e[0] && doubletap_time > 0:
						input_doubletap = e[1]
					else:
						last_action = e[0]
						input_doubletap = 0
						doubletap_time = DOUBLETAP_DELAY
					return
		elif event.is_released():
			if (
				not Input.is_action_pressed("move_left")
				and not Input.is_action_pressed("move_right")
			):
				input_horizontal = 0
			elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
				input_horizontal = -1
			elif not Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
				input_horizontal = 1
	elif event is InputEventMouseButton:
		if Input.is_action_just_pressed("attack"):
			print("Emitting attack singal")
			attack_signal.emit()
		mouse_position = event.position
		print("Mouse Motion at: ", event.position)


func GetMousePosition() -> Vector2:
	return mouse_position


func _process(delta: float) -> void:
	doubletap_time -= delta
	#var axis = Input.get_axis("move_left", "move_right")


func GetHomingInput() -> bool:
	return Input.is_action_just_pressed("homing")


func GetJumpInput() -> bool:
	return Input.is_action_pressed("jump")


func GetSpecialInput() -> bool:
	return Input.is_action_just_pressed("suit_power")


func GetSwapInput() -> bool:
	#return Input.is_action_just_pressed("suit_swap")
	return false;


func GetAttackInput() -> bool:
	return Input.is_action_just_pressed("attack")


func GetDebugInput() -> bool:
	return Input.is_action_just_pressed("debug_combo")
