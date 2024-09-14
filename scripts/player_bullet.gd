extends Node2D
var travel_time: float = 3.
var travel_speed: float = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if travel_time > 0:
		position.x += travel_speed * delta
		travel_time -= delta
