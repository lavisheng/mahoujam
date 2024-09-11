extends CharacterBody2D

signal been_hit


@export_subgroup("Nodes")
@export var enemy_gravity_component: EnemyGravityComponent
@export var health_component: HealthComponent
@export var projectile_fc_component: EnemyProjectileFireControlComponent

@export_subgroup("Settings")
@export var launch_force: int = -500
@export var juggle_force: int = -200

var cooldown: float = 1.
var hitstop_delta: float = 0.

func _enter_tree() -> void:
	var p: Player = get_parent().get_node("Player")
	been_hit.connect(p.HandleHitCallback)
	health_component.on_death.connect(p.HandleKillCallback)

func _physics_process(delta):
	hitstop_delta = clamp(hitstop_delta - delta, 0, 1)
	if (hitstop_delta <= 0):
		enemy_gravity_component.HandleGravity(self, delta)
		cooldown -= delta
		if cooldown < 0:
			cooldown = 1.
			var test_proj_func = func(projectile: Node2D, _target: Vector2, d: float):
				projectile.position.x += 100 * d
			projectile_fc_component.Fire(self, Vector2(1,0), Vector2(10,0), test_proj_func)
	move_and_slide() 


# extract to future enemy movement script
func HandleAttack(damage: int, launch_vel: float, x_vel_hit = 0) -> void:
	print("x_vel: %s" % x_vel_hit)
	health_component.TakeDamage(damage)
	velocity.y = launch_vel
	velocity.x = x_vel_hit
	been_hit.emit()
	#EventBus.SendEvent( "ComboIncrement", false );
