class_name HealthComponent
extends Node

signal on_death(bar_gain)

@export_subgroup("Settings")
@export var max_health: int = 10
@export var bar_gain: int= 0.

@onready var health: int = max_health


func TakeDamage(damage: int) -> void:
	health = clamp(health - damage, 0, max_health)


func Die() -> void:
	on_death.emit(bar_gain)
	get_parent().queue_free()
	#get_tree().change_scene_to_file( "res://scenes/UI/death_screen.tscn" );


func _process(_delta: float) -> void:
	if health <= 0:
		Die()


func _on_attack_component_body_entered(body):
	print(body)
	TakeDamage(5)

func GetHealth():
	return health;