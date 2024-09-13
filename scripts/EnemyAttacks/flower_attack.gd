extends "res://scripts/EnemyAttacks/enemy_attack_base.gd"

@export var particles: GPUParticles2D

func SetEnable(enable: bool) -> void:
	super(enable)
	particles.set_emitting(enable)
