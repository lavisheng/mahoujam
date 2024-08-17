class_name GravityComponent
extends Node2D

@export_subgroup("Settings")
@export var gravity: float = 1000.0
@export var airdash: bool = false
var is_falling: bool = false;

func handle_gravity(body: CharacterBody2D, delta:float) -> void:
    if not body.is_on_floor() and not airdash:
        body.velocity.y += gravity * delta
        is_falling = true
    elif body.is_on_floor():
         is_falling = false   
