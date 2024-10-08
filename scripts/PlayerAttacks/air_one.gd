extends "res://scripts/PlayerAttacks/player_attack_base.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body):
	if body is MeleeEnemy or body is Enemy:
		if body.is_on_floor():
			body.HandleAttack(damage, vertical_velocity)
		else:
			body.HandleAttack(damage, vertical_velocity / 2.)
