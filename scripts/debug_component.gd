class_name DebugComponent extends Node

@export var comboManagerNode: ComboManager

# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
# 	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass


func DebugCombo(inputPressed: bool) -> void:
	if inputPressed:
		EventBus.SendEvent( "ComboIncrement", false );
