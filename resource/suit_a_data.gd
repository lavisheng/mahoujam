#extends "res://resource/suit_data.gd"

class_name Suit_a extends SuitData

@export var giga_jump_vel: float = -700

@export_subgroup("Settings")
const HOVER_TIME = 4.
@export var hover_time: float = 0.0
const OFFSET = [Vector2(-17, 0), Vector2(0, -17), Vector2(17, 0)]
var bullets = [-1, -1, -1]
var shoot_index = 3


func SuitAbilityCallback(body: CharacterBody2D, wantInput: bool):
    if wantInput and not body.is_on_floor() and shoot_index == 3:
        hover_time = HOVER_TIME
        shoot_index = 0
        for i in range(3):
            bullets[i] = load("res://scenes/components/suite_a_bullet.tscn").instantiate()
            bullets[i].transform = bullets[i].transform.translated(
                body.transform.get_origin() + OFFSET[i]
            )
            body.get_parent().add_child(bullets[i])
        body.velocity = Vector2(0, 0)
    #do a giga jump ( of hell )
    #if wantInput and body.is_on_floor():
    #    body.velocity.y = giga_jump_vel
    print("I'm an overloaded suit a")

func SuitAbilityProcess(body: CharacterBody2D, wantInput: bool, delta: float):
    if hover_time > 0 and shoot_index < 3:
        hover_time -= delta
        body.velocity.y = 0
        if wantInput:
            bullets[shoot_index].fire_bullet()
            shoot_index += 1
