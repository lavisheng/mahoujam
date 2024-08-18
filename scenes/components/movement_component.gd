class_name MovementComponent
extends Node2D
@export var gravity_component:  GravityComponent
@export_subgroup("Settings")
@export var ground_speed: float = 100
@export var air_speed: float = 2000
const NUM_AIRDASHES = 2
var num_airdashes: int = NUM_AIRDASHES
var airdash_delta: float = .75

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
    #if body.is_on_floor():
    if not gravity_component.is_falling:
        body.velocity.x = direction * ground_speed
    #else:
        #body.velocity.x = air_speed * direction
func handle_air_dash(body: CharacterBody2D, direction: float, delta: float) -> void:
    if not body.is_on_floor() and direction != 0 and num_airdashes > 0:
        body.velocity.x = direction * air_speed
        gravity_component.airdash = true
        body.velocity.y = 0
        num_airdashes -= 1  
        airdash_delta = .75
    elif gravity_component.airdash and airdash_delta > 0:
        airdash_delta -= delta
        body.velocity.x *= airdash_delta * airdash_delta*airdash_delta #direction * airdash_delta * airdash_delta * (ground_speed + air_speed)
        if abs(body.velocity.x) <= 0.05:
            #airdash_delta = .75
            gravity_component.airdash = false
    elif body.is_on_floor():
        num_airdashes = NUM_AIRDASHES
