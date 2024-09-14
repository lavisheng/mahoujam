extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Player_HUD.visible = false
	Dialogic.start("Intro")
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	%Player_HUD.visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
