class_name ComboManager extends Node

@export var combo_array: Array[ComboData] = []

var currentCombo: int = 0
var currentComboIdx: int = -1
var activeCombo: ComboData = null

@export var HUDListener: PlayerHUD


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.Subscribe( "ComboIncrement", self, "ModifyCombo" );
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func ModifyCombo(reset: bool) -> void:
	if reset:
		currentCombo = 0
		currentComboIdx = -1
		activeCombo = null
	else:
		currentCombo += 1
		if currentCombo > combo_array[currentComboIdx + 1].comboFloor:
			currentComboIdx += 1
			activeCombo = combo_array[currentComboIdx]

	#consideration: add hud to the event bus, or send a new event here rather than having a direct connection
	HUDListener.UpdateComboEvent(activeCombo, currentCombo)
