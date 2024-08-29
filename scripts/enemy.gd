extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var health_component: HealthComponent
@export var projectile_fc_component: EnemyProjectileFireControlComponent
var cooldown: float = 1.

func _physics_process(delta):
    gravity_component.handle_gravity(self, false, delta)
    move_and_collide(self.velocity * delta)
    cooldown -= delta
    if cooldown < 0:
        cooldown = 1.
		var test_proj_func = func(projectile: Node2D, _target: Vector2, d: float):
            projectile.position.x += 100 * d
        projectile_fc_component.fire(self, Vector2(1,0), Vector2(2,0), test_proj_func)
