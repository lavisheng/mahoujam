class_name PlayerHUD extends Control

@export var statusText: RichTextLabel
@export var comboCtr: RichTextLabel
@export var comboManagerNode: ComboManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	statusText.text = ""
	comboCtr.text = ""
	pass  # Replace with function body.


func UpdateComboEvent(newData: ComboData, currentCombo: int) -> void:
	if newData:
		statusText.text = newData.comboIdentifier

	comboCtr.text = str(currentCombo)
	pass
