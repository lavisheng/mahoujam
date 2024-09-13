extends "res://scripts/EnemyAttacks/enemy_attack_base.gd"

func _enter_tree() -> void:
	left_facing_transform = transform
	right_facing_transform = transform * Transform2D.FLIP_X
	right_facing_transform.origin.x *= -1


func _on_area_entered(area: Area2D) -> void:
	if area is PlayerHurtbox:
		area.HitPlayer(damage)
