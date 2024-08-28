class_name SuitABullet
extends Area2D
var travel_max_speed: float = 1000
var fire: bool = false
const TRAVEL_TIME = 1.
var travel_time: float = TRAVEL_TIME
const TURNING_SPEED = 0.1 * PI
var target: Vector2 = Vector2(0, 0)
var target_angle: float = 0.
var angle: float = 0.
var initial_angle: float = 0.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func SetDirection(facing_right: bool) -> void:
	if not facing_right:
		print("NOT FACING RIGHT")
		angle = PI
		set_rotation(angle)


func GetVelocityComponents(velocity: float) -> Vector2:
	return Vector2(velocity * cos(angle), velocity * sin(angle))


func InterpolateAngle() -> void:
	var t = 8 / TRAVEL_TIME * (TRAVEL_TIME - travel_time)
	if t <= 1:
		angle = initial_angle * (1 - t) + target_angle * t
	else:
		angle = target_angle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fire:
		travel_time -= delta
		if travel_time > 0:
			# update angle first
			InterpolateAngle()
			set_rotation(angle)
			# move the object
			position += (
				delta * GetVelocityComponents(travel_max_speed * sqrt(TRAVEL_TIME - travel_time))
			)
		else:
			queue_free()
		#position.x += travel_speed * delta


func _on_body_entered(body: Node2D):
	print("COLLIDE")


func fire_bullet(aim: Vector2) -> void:
	fire = true
	target = aim
	target_angle = position.angle_to_point(aim)
	initial_angle = angle
	print("ANGLE TARGET: %s, ANGLE: %s" % [target_angle, angle])
