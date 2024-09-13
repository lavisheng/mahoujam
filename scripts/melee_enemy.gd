class_name MeleeEnemy
extends CharacterBody2D

signal been_hit


@export_subgroup("Nodes")
@export var enemy_gravity_component: EnemyGravityComponent
@export var health_component: HealthComponent
#@export var projectile_fc_component: EnemyProjectileFireControlComponent
@export var enemy_data: EnemyData
@export var collision_shape: CollisionShape2D
@export var enemy_attack: EnemyAttackBase
@export var _animation_player: AnimationPlayer

@export_subgroup("Settings")
@export var launch_force: int = -500
@export var juggle_force: int = -200
@export var facing_right: bool = true

func _enter_tree() -> void:
	var p: Player = get_parent().get_node("Player")
	been_hit.connect(p.HandleHitCallback)
	health_component.on_death.connect(p.HandleKillCallback)
	enemy_attack.damage = enemy_data.bulletDamage
	SetAnimation("IdleMode")

enum ATTACK_PHASE {STARTUP, ACTIVE, RECOVERY}
var cooldown: float = 1.
var hitstop_delta: float = 0.


var in_attack: bool = false
var player_visible: bool = false
var attack_phase: ATTACK_PHASE
var playerWasVisible: bool = false
var is_turning: bool = false
@onready var turn_delta: float = enemy_data.turnPause


func _physics_process(delta):
	hitstop_delta = clamp(hitstop_delta - delta, 0, 1)
	if (hitstop_delta > 0):
		return
	enemy_gravity_component.HandleGravity(self, delta)
	if !is_on_floor():
		move_and_slide()
		return
	var space_state = get_world_2d().direct_space_state
	var player_query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(1000 * (1 if facing_right else -1), 0), 1)
	var result = space_state.intersect_ray(player_query)
	var playerWasVisible = false
	if result.is_empty() and player_visible:
		playerWasVisible = true
	player_visible = !result.is_empty()
	if not player_visible and !in_attack:
		
		# patrol
		if !enemy_data.isStationary:
			if is_turning:
				turn_delta = clamp(turn_delta - delta, 0, enemy_data.turnPause)
				if (turn_delta <= 0):
					facing_right = !facing_right
					is_turning = false
			elif facing_right:
				var right_edge_origin = global_position + Vector2(collision_shape.shape.get_rect().size.x / 2, 0)
				var right_edge_query = PhysicsRayQueryParameters2D.create(right_edge_origin, right_edge_origin - (Vector2.UP * 100), 4)
				var right_edge_result = space_state.intersect_ray(right_edge_query)
				if get_wall_normal().x == -1:
					velocity.x = 0
					is_turning = true
					turn_delta = enemy_data.turnPauseAtWall
				elif right_edge_result.is_empty():
					velocity.x = 0
					is_turning = true
					turn_delta = enemy_data.turnPause
				else:
					velocity.x = enemy_data.patrolSpeed
			else:
				var left_edge_origin = global_position - Vector2(collision_shape.shape.get_rect().size.x / 2, 0)
				var left_edge_query = PhysicsRayQueryParameters2D.create(left_edge_origin, left_edge_origin - (Vector2.UP * 100), 4)
				var left_edge_result = space_state.intersect_ray(left_edge_query)
				if get_wall_normal().x == 1:
					velocity.x = 0
					is_turning = true
					turn_delta = enemy_data.turnPauseAtWall
				elif left_edge_result.is_empty():
					velocity.x = 0
					is_turning = true
					turn_delta = enemy_data.turnPause
				else:
					velocity.x = enemy_data.patrolSpeed * -1
		else:
			if playerWasVisible:
				turn_delta = enemy_data.turnPause
				playerWasVisible = false
			else:
				turn_delta = clamp(turn_delta - delta, 0, enemy_data.turnPause)
				if turn_delta <= 0:
					facing_right = !facing_right
					turn_delta = enemy_data.turnPause
	else:
		# attack
		if not in_attack:
			SetAnimation("AttackMode")
			velocity.x = 0
			in_attack = true
			attack_phase = ATTACK_PHASE.STARTUP
			#print("startup")
			cooldown = enemy_data.startupTime
			return
		
		cooldown -= delta
			
		if cooldown <= 0:
			match attack_phase:
				ATTACK_PHASE.STARTUP:
					cooldown += enemy_data.activeTime
					attack_phase = ATTACK_PHASE.ACTIVE
					enemy_attack.SetEnable(true)
					enemy_attack.SetOrientation(facing_right)
					#print("active")
				ATTACK_PHASE.ACTIVE:
					cooldown += enemy_data.recoveryTime
					attack_phase = ATTACK_PHASE.RECOVERY
					enemy_attack.SetEnable(false)
					#print("recovery")
				ATTACK_PHASE.RECOVERY:
					in_attack = false
					SetAnimation("IdleMode")
	#print(velocity) 
	move_and_slide()

func SetAnimation(anim_string: String) -> void:
	var sprite: Sprite2D = $Sprite2D
	sprite.flip_h = not facing_right
	_animation_player.play(anim_string)
	
# extract to future enemy movement script
func HandleAttack(damage: int, launch_vel: float, x_vel_hit = 0) -> void:
	#print("x_vel: %s" % x_vel_hit)
	health_component.TakeDamage(damage)
	velocity.y = launch_vel
	velocity.x = x_vel_hit
	been_hit.emit()
