extends Node

@export var combo_array: Array[ComboData] = [];

var currentCombo:int  = 0;
var currentComboIdx:int = -1;
var activeCombo:ComboData = null;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ModifyCombo( reset: bool ) -> void:
	if reset: 
		currentCombo = 0;
		currentComboIdx = -1;
		activeCombo = null;
	else:
		++currentCombo;
		if currentCombo > combo_array[currentComboIdx + 1].comboFloor:
			++currentComboIdx;
			activeCombo = combo_array[currentComboIdx];
			# TODO Update the UI here!!!	
	pass;