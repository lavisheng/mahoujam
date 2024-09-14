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

var BAR_MAX: int = 100
var bar_percentage: int = 0


func SuitAbilityCallback(player: Player):
	pass


func SuitAbilityProcess(player: Player, delta: float):
	pass


func SuitCollisionCallback(player: Player):
	pass


func AddBar(val: int) -> void:
	bar_percentage = clamp(bar_percentage + val, 0, BAR_MAX)


func SuitHitBodyCallback(player: Player, damage: int) -> void:
	player.health_component.TakeDamage(damage)


func SuitHitLegCallback(player: Player, damage: int) -> void:
	player.health_component.TakeDamage(damage)
