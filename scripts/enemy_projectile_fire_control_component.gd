class_name EnemyProjectileFireControlComponent
extends Node2D

@export var projectile_path: String = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


## This function is used to spawn and fire projectiles for a given enemy
## Enemy - the enemy character that calls this component
## target - the point that the enemy is aiming towards
## offset - the offset to spawn the projectile from the enemy
## travel_func - a callable that takes in: the projectile, the target vector2
## and a delta, is called while fire is active in order to determine how the projectile
## travels or changes.
func Fire(enemy: Node2D, target: Vector2, offset: Vector2, travel_func: Callable) -> void:
	var projectile = load(projectile_path).instantiate()
	print(projectile)
	projectile.transform = projectile.transform.translated(enemy.transform.get_origin() + offset)
	projectile.enemy_projectile_component.Fire(projectile, target, travel_func)
	enemy.get_parent().add_child(projectile)
