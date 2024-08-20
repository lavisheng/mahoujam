#extends "res://resource/suit_data.gd"

class_name Suit_a extends SuitData

@export var giga_jump_vel: float = -700


func SuitAbilityCallback(body: CharacterBody2D, wantInput: bool):
	#do a giga jump ( of hell )
	if wantInput and body.is_on_floor():
		body.velocity.y = giga_jump_vel
	print("I'm an overloaded suit a")
