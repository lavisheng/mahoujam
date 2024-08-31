extends Resource

class_name SuitData

@export var suitColor: Color
@export var name: String
@export var airSpeedDelta: int
@export var airSpeedMultiplier: float
@export var landSpeedDelta: int
@export var landSpeedMultiplier: float
@export var jumpPowerMultiplier: float
@export var air_movement: bool


func SuitAbilityCallback(player: Player):
	pass


func SuitAbilityProcess(player: Player, delta: float):
	pass


func SuitCollisionCallback(player: Player):
	pass
