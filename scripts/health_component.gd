class_name HealthComponent
extends Node

@export_subgroup("Settings")
@export var max_health: int = 10

var health: int = max_health


func take_damage(damage: int) -> void:
    health = clamp(health - damage, 0, max_health)


func die() -> void:
    get_parent().queue_free()


func _process(_delta: float) -> void:
    if health == 0:
        die()


func _on_attack_component_body_entered(body):
    print(body)
    take_damage(5)
