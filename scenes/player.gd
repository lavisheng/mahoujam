extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component:  GravityComponent
@export var input_component:    InputComponent
@export var movement_component: MovementComponent
@export var jump_component:     JumpComponent

func _physics_process(delta):
    #print("IS ON FLOOR %s" % gravity_component.airdash )
    gravity_component.handle_gravity(self, delta)
    movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
    movement_component.handle_air_dash(self, input_component.input_doubletap, delta)
    jump_component.handle_jump(self, input_component.get_jump_input())
    input_component.input_doubletap = 0
    move_and_slide()
