extends "res://scripts/EnemyAttacks/enemy_attack_base.gd"

@export var particles: GPUParticles2D

func SetEnable(enable: bool) -> void:
	super(enable)
	particles.set_emitting(enable)


func _on_area_entered(area: Area2D) -> void:
	if area is PlayerHurtbox:
		print("HIT")
		area.HitPlayer(damage)
