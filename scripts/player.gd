class_name Player
extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var suit_component: SuitComponent
@export var attack_component: AttackComponent
@export var health_component: HealthComponent
@export var debugComponent: DebugComponent

#@export var homing_target :     Node
@export var active_suit: SuitData
@export var inactive_suit: SuitData
var bullets = 1
var bullet = null
var facing_right = true
var hitstop_delta: float = 0.


func _ready() -> void:
	modulate = inactive_suit.suitColor
	input_component.attack_signal.connect(HandleAttackCallback)
	health_component.on_death.connect(HandleKillCallback)


# for signal purposes
func HandleAttackCallback() -> void:
	print("Attack Signal Received")
	attack_component.HandleAttack(self)


func HandleHitCallback() -> void:
	active_suit.AddBar(attack_component.curr.bar_gain)


func HandleKillCallback(bar_gain: float) -> void:
	active_suit.AddBar(bar_gain)


func _physics_process(delta):
	#attack_component.HandleAttack(self, input_component.GetAttackInput(), facing_right)
	if (
		not attack_component.curr.cancellable
		and attack_component.curr.state <= Global.MOVE_STATE.active
	):
		return
	#hitstop_delta = clamp(hitstop_delta - delta, 0, 1)
	#if hitstop_delta > 0:
	#	return
	gravity_component.HandleGravity(self, active_suit.air_movement, delta)
	movement_component.HandleHorizontalMovement(
		self,
		input_component.input_horizontal,
		active_suit.land_speed_delta,
		active_suit.land_speed_multiplier
	)
	movement_component.HandleAirMovement(
		self,
		input_component.input_horizontal,
		active_suit.air_speed_delta,
		active_suit.air_speed_multiplier
	)
	movement_component.HandleJump(
		self, input_component.GetJumpInput(), active_suit.jump_power_multiplier, delta
	)
	movement_component.Landed(self)
	suit_component.ActivatePower(self, active_suit)
	suit_component.ProcessPower(self, active_suit, delta)
	suit_component.ProcessSuitSwap(self, active_suit, inactive_suit, input_component.GetSwapInput())
	input_component.input_doubletap = 0
	move_and_slide()
	if get_slide_collision_count() > 0:
		suit_component.CollideSuit(self, active_suit)
	debugComponent.DebugCombo(input_component.GetDebugInput())
