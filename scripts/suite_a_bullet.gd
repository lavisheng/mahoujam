class_name SuitABullet
extends Sprite2D
var travel_speed: float = 1000
var fire: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if fire:
        position.x += travel_speed * delta


func fire_bullet() -> void:
    fire = true
