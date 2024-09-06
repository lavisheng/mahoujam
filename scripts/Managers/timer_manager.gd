extends Node2D

var totalTime = 0;
var shouldCount = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.Subscribe( "LevelStart", self, "StartTimer" );
	EventBus.Subscribe( "LevelEnd", self, "StopTimer" );
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shouldCount:
		totalTime = totalTime + delta;
	pass

func StartTimer():
	shouldCount = true;

func StopTimer():
	shouldCount = false;