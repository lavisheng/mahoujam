extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func StartGame() -> void:
	get_tree().change_scene_to_file( "res://scenes/Levels/Level_1.tscn" );

func GoToMainScene() -> void:
	get_tree().change_scene_to_file( "res://scenes/UI/main_scene.tscn" );

func Exit() -> void:
	get_tree().quit();