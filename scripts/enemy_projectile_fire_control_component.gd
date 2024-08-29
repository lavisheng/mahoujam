class_name EnemyProjectileFireControlComponent
extends Node2D

@export var projectile_path: String = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func fire(enemy: Node2D, target: Vector2, offset: Vector2, travel_func: Callable) -> void:
	var projectile = load(projectile_path).instantiate()
	enemy.add_child(projectile)
	print(projectile)
	projectile.transform = projectile.transform.translated(enemy.transform.get_origin() + offset)
	projectile.enemy_projectile_component.fire(projectile, target, travel_func)
