extends Area2D
@export var enemy_projectile_component: EnemyProjectileComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	body.health_component.take_damage(4)
	print("HIT")
	queue_free()
