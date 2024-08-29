extends CharacterBody2D

@export_subgroup("Nodes")
@export var enemy_gravity_component: EnemyGravityComponent
@export var health_component: HealthComponent

@export_subgroup("Settings")
@export var launch_force: int = -500
@export var juggle_force: int = -200

var hitstop_delta: float = 0.


func _physics_process(delta):
	hitstop_delta = clamp(hitstop_delta - delta, 0, 1)
	if (hitstop_delta > 0):
		return
	enemy_gravity_component.handle_gravity(self, delta)
	move_and_slide() 


# extract to future enemy movement script
func handle_attack(damage: int) -> void:
	health_component.take_damage(damage)
	if is_on_floor():
		velocity.y = launch_force
	else:
		velocity.y = juggle_force
