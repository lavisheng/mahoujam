class_name SuitComponent extends Node

# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
#   pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
#   pass


func ActivatePower(body: CharacterBody2D, suit: SuitData, inputPressed: bool) -> void:
	suit.SuitAbilityCallback(body, inputPressed)


func ProcessPower(body: CharacterBody2D, suit: SuitData, inputPressed: bool, delta: float) -> void:
	suit.SuitAbilityProcess(body, inputPressed, delta)
