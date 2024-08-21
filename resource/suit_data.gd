extends Resource

class_name SuitData

@export var suitColor: Color
@export var name: String
@export var airSpeedDelta: int
@export var airSpeedMultiplier: float
@export var landSpeedDelta: int
@export var landSpeedMultiplier: float
@export var jumpPowerMultiplier: float


func SuitAbilityCallback(body: CharacterBody2D, wantInput: bool):
    pass

func SuitAbilityProcess(body: CharacterBody2D, wantInput: bool, delta: float):
    pass
