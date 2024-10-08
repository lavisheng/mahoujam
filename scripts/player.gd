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
#@export var combo_component: ComboComponent

#@export var homing_target :     Node
@export var active_suit: SuitData
@export var inactive_suit: SuitData
@onready var animation_player: AnimationPlayer = %AnimationPlayer
var bullets = 1
var bullet = null
var facing_right = true
var hitstop_delta: float = 0.

var hit_body: bool = false
var hit_leg: bool = false


func _ready() -> void:
	input_component.attack_signal.connect(HandleAttackCallback)
	health_component.on_death.connect(HandleKillCallback)
	SetAnimation("Idle")


func SetAnimation(anim_string: String) -> void:
	var sprite: Sprite2D = $Sprite2D
	sprite.flip_h = not facing_right
	animation_player.play(anim_string)

# for signal purposes
func HandleAttackCallback() -> void:
	print("Attack Signal Received")
	attack_component.HandleAttack(self)


func HandleHitCallback() -> void:
	active_suit.AddBar(attack_component.curr.bar_gain)
	EventBus.SendEvent( "ComboIncrement", false )


func HandleKillCallback(bar_gain: int) -> void:
	active_suit.AddBar(bar_gain)


# handling hurtbox
func HandleBodyHit(damage: int) -> void:
	if not hit_leg:
		suit_component.HitSuitBody(self, active_suit, damage)
		hit_body = true


func HandleLegHit(damage: int) -> void:
	if not hit_body:
		suit_component.HitSuitLeg(self, active_suit, damage)
		hit_leg = true


func _physics_process(delta):
	#attack_component.HandleAttack(self, input_component.GetAttackInput(), facing_right)
	if (
		not attack_component.curr.cancellable
		and attack_component.curr.state <= Global.MOVE_STATE.active
	):
		return
	elif attack_component.curr.state == Global.MOVE_STATE.rest and is_on_floor():
		EventBus.SendEvent( "ComboIncrement", true)
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
	hit_leg = false
	hit_body = false


func _on_intro_finished() -> void:
	%Intro.stop() 
	%SongLoop.play(0.)

	 
