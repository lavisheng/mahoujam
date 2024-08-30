class_name Player
extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var suit_component: SuitComponent
@export var attack_component: AttackComponent
@export var health_component: HealthComponent
#@export var homing_target :     Node
@export var active_suit: SuitData
@export var inactive_suit: SuitData
var bullets = 1
var bullet = null
var facing_right = true
var hitstop_delta: float = 0.


func _ready() -> void:
    modulate = inactive_suit.suitColor


func _physics_process(delta):
    hitstop_delta = clamp(hitstop_delta - delta, 0, 1)
    if (hitstop_delta > 0):
        return
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
    attack_component.handle_attack(self, input_component.get_attack_input(), facing_right)
    move_and_slide()
    if get_slide_collision_count() > 0:
        suit_component.CollideSuit(self, active_suit)
