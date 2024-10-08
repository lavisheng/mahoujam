class_name EnemyProjectileComponent
extends Node2D
@export var projectile_lifetime: float = 2.
var projectile: Node2D = self
var fired: bool = false
var travel_func: Callable = Callable()
var target_loc: Vector2 = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if fired and projectile_lifetime > 0:
		projectile_lifetime -= delta
		travel_func.call(projectile, target_loc, delta)
	else:
		get_parent().queue_free()


func Fire(proj: Node2D, target: Vector2, callable: Callable) -> void:
	fired = true
	travel_func = callable
	target_loc = target
	projectile = proj
