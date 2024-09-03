extends Resource

class_name SuitData

@export var suitColor: Color
@export var name: String
@export var air_speed_delta: int
@export var air_speed_multiplier: float
@export var land_speed_delta: int
@export var land_speed_multiplier: float
@export var jump_power_multiplier: float
@export var air_movement: bool

#@export_group("Moves")
#@export var ground_attack: PlayerAttackBase
#@export var air_one_attack: PlayerAttackBase
#@export var air_two_attack: PlayerAttackBase


func SuitAbilityCallback(player: Player):
	pass


func SuitAbilityProcess(player: Player, delta: float):
	pass


func SuitCollisionCallback(player: Player):
	pass
