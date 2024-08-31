extends CharacterBody2D

@export_subgroup("Nodes")
@export var enemy_gravity_component: EnemyGravityComponent
@export var health_component: HealthComponent
@export var projectile_fc_component: EnemyProjectileFireControlComponent

@export_subgroup("Settings")
@export var launch_force: int = -500
@export var juggle_force: int = -200

var cooldown: float = 1.
var hitstop_delta: float = 0.


func _physics_process(delta):
	hitstop_delta = clamp(hitstop_delta - delta, 0, 1)
	if (hitstop_delta > 0):
		return
	enemy_gravity_component.HandleGravity(self, delta)
	cooldown -= delta
	if cooldown < 0:
		cooldown = 1.
		var test_proj_func = func(projectile: Node2D, _target: Vector2, d: float):
			projectile.position.x += 100 * d
		projectile_fc_component.Fire(self, Vector2(1,0), Vector2(10,0), test_proj_func)
	move_and_slide() 


# extract to future enemy movement script
func HandleAttack(damage: int) -> void:
	health_component.TakeDamage(damage)
	if is_on_floor():
		velocity.y = launch_force
	else:
		velocity.y = juggle_force
