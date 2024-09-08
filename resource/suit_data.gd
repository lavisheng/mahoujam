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

var BAR_MAX: float = 1.0
var bar_percentage: float = 0.0


func SuitAbilityCallback(player: Player):
	pass


func SuitAbilityProcess(player: Player, delta: float):
	pass


func SuitCollisionCallback(player: Player):
	pass


func AddBar(val: float) -> void:
	bar_percentage = clamp(bar_percentage + val, 0., BAR_MAX)
