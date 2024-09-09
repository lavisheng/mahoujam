#extends "res://resource/suit_data.gd"

class_name Suit_b extends SuitData

const NUM_AIRDASHES = 2
const FRAME = 1 / 60.
@export_subgroup("Settings")
var num_airdashes: int = NUM_AIRDASHES
@export var airdash_delta: float = .75
@export var dash_speed: float = 2000
@export var jump_velocity: float = -250.0
@export var special_jump_velocity: float = -600
@export var special_dash_startup: float = 900
@export var special_dash_speed: float = 1000
@export var projectile_frame_jump_window: int = 10

var projectile_jump_timer = 0
var leg_damage: int = 0

var special_move: bool = false
var special_roll_delta: float = 1.


func SuitAbilityCallback(player: Player) -> void:
	if (
		player.gravity_component.is_falling
		and player.input_component.GetSpecialInput()
		and not air_movement
		and player.attack_component.SuitBSpecial(player.facing_right)
	):
		if player.facing_right:
			player.velocity.x = special_dash_startup
		else:
			player.velocity.x = -1 * special_dash_startup
		player.velocity.y = 0
		air_movement = true
		special_move = true


func HandleAirDash(player: Player, direction: float, delta: float) -> void:
	if not special_move and not player.is_on_floor() and direction != 0 and bar_percentage > 0.2:
		player.velocity.x = direction * dash_speed
		air_movement = true
		player.velocity.y = 0
		airdash_delta = .75
		bar_percentage = clamp(bar_percentage - 0.2, 0., 1.)
	elif air_movement and airdash_delta > 0:
		airdash_delta -= delta
		player.velocity.x *= airdash_delta * airdash_delta * airdash_delta
		if abs(player.velocity.x) <= 0.05:
			air_movement = false


func HandleDoubleJump(player: Player) -> void:
	if (
		not player.movement_component.is_jumping
		and player.input_component.GetJumpInput()
		and bar_percentage > 0.2
		and projectile_jump_timer <= 0
	):
		player.velocity.y = jump_velocity * jump_power_multiplier
		bar_percentage = clamp(bar_percentage - 0.2, 0., 1.)


func SuitHitLegCallback(player: Player, damage: int) -> void:
	if player.is_on_floor():
		player.health_component.TakeDamage(damage)
	else:
		projectile_jump_timer = FRAME * projectile_frame_jump_window
		# store leg damage for later
		leg_damage = damage


func HandleProjectileJump(player: Player, delta: float) -> void:
	projectile_jump_timer -= delta
	if projectile_jump_timer > 0:
		if player.input_component.GetJumpInput():
			print("JUMPED OFF OF PROJECTILE")
			player.velocity.y = jump_velocity * jump_power_multiplier
			projectile_jump_timer = 0
	else:
		player.health_component.TakeDamage(leg_damage)


func SuitAbilityProcess(player: Player, delta: float) -> void:
	print("BAR PERCENTAGE %s" % bar_percentage)
	if special_move:
		if player.attack_component.curr.state >= Global.MOVE_STATE.recovery:
			# dash over
			player.velocity.x = 0
			special_move = false
		elif player.attack_component.curr.state >= Global.MOVE_STATE.active:
			if player.facing_right:
				player.velocity.x = special_dash_speed
			else:
				player.velocity.x = -1 * special_dash_speed
	else:
		HandleAirDash(player, player.input_component.input_doubletap, delta)
		HandleDoubleJump(player)
		HandleProjectileJump(player, delta)
	if player.is_on_floor():
		num_airdashes = NUM_AIRDASHES
