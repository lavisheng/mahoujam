extends "res://scripts/PlayerAttacks/player_attack_base.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body):
	if body.has_method("HandleAttack"):
		print("hit suit b attack")
		body.HandleAttack(damage, vertical_velocity, 900.)
		print(get_parent().get_parent())


func _on_body_exited(body: Node2D) -> void:
	body.velocity.x = 0
