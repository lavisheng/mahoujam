class_name PlayerHUD extends Control

@export var statusText: RichTextLabel
@export var comboCtr: RichTextLabel
@export var comboManagerNode: ComboManager
@export var player: Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	statusText.text = ""
	comboCtr.text = ""
	%Health.max_value = player.health_component.max_health
	%Resource.max_value = 100

func _physics_process(delta: float) -> void:
	%Health.value = player.health_component.health
	%Resource.value = player.active_suit.bar_percentage

func UpdateComboEvent(newData: ComboData, currentCombo: int) -> void:
	if newData:
		statusText.text = newData.comboIdentifier

	comboCtr.text = str(currentCombo)
	pass
