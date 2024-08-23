class_name Player
extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var suit_component: SuitComponent
#@export var homing_target :     Node
@export var active_suit: SuitData
@export var inactive_suit: SuitData
var bullets = 1
var bullet = null


func _ready() -> void:
	modulate = inactive_suit.suitColor


func _physics_process(delta):
	gravity_component.handle_gravity(self, active_suit.air_movement, delta)
	movement_component.handle_horizontal_movement(
		self,
		input_component.input_horizontal,
		active_suit.landSpeedDelta,
		active_suit.landSpeedMultiplier
	)
	movement_component.handle_air_movement(
		self,
		input_component.input_horizontal,
		active_suit.airSpeedDelta,
		active_suit.airSpeedMultiplier
	)
	movement_component.handle_jump(
		self, input_component.get_jump_input(), active_suit.jumpPowerMultiplier, delta
	)
	movement_component.landed(self)
	suit_component.ActivatePower(self, active_suit)
	suit_component.ProcessPower(self, active_suit, delta)
	suit_component.ProcessSuitSwap(
		self, active_suit, inactive_suit, input_component.get_swap_input()
	)
	input_component.input_doubletap = 0
	move_and_slide()
