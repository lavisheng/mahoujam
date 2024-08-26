extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var attack_component: AttackComponent

#@export var homing_target :     Node
var bullets = 1
var bullet = null
var facing_right = true

#var bullet
func fire():
	if bullets > 0:
		bullet = load("res://scenes/player_bullet.tscn").instantiate()
		bullet.transform = bullet.transform.translated(self.transform.get_origin())
		get_parent().add_child(bullet)
		bullets -= 1


func _physics_process(delta):
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	movement_component.handle_air_dash(self, input_component.input_doubletap, delta)
	attack_component.handle_attack(self, input_component.get_attack_input(), facing_right)
	if input_component.get_fire_input():
		fire()
	if bullet != null:
		movement_component.handle_homing_dash(
			self, bullet.transform, delta, input_component.get_homing_input()
		)
	jump_component.handle_jump(self, input_component.get_jump_input())
	input_component.input_doubletap = 0
	movement_component.landed(self)
	move_and_slide()
