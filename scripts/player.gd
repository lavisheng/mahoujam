extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity: GravityComponent
@export var input: InputComponent
@export var movement: MovementComponent
@export var jump: JumpComponent

func _physics_process(delta: float) -> void:
	gravity.handle_gravity(self, delta)
	movement.handle_horizontal_movement(self, input.input_horizontal)
	jump.handle_jump(self, input.get_jump_input())

	move_and_slide()
