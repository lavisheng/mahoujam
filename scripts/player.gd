extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var suit_component: SuitComponent
#@export var homing_target :     Node
@export var active_suit: SuitData
var bullets = 1
var bullet = null


#var bullet
func fire():
	if bullets > 0:
		bullet = load("res://scenes/player_bullet.tscn").instantiate()
		bullet.transform = bullet.transform.translated(self.transform.get_origin())
		get_parent().add_child(bullet)
		bullets -= 1


func _physics_process(delta):
	gravity_component.handle_gravity(self, delta)
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
	movement_component.handle_air_dash(self, input_component.input_doubletap, delta)
	if input_component.get_fire_input():
		fire()
	if bullet != null:
		movement_component.handle_homing_dash(
			self, bullet.transform, delta, input_component.get_homing_input()
		)
	jump_component.handle_jump(
		self, input_component.get_jump_input(), active_suit.jumpPowerMultiplier
	)
	input_component.input_doubletap = 0
	movement_component.landed(self)
	suit_component.ActivatePower(self, active_suit, input_component.get_sepcial_input())
	move_and_slide()
