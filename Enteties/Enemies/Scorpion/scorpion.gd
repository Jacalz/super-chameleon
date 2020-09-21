extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 100
const GRAVITY = 1450

var velocity = Vector2()

onready var LeftD = $FloorDetector/Left
onready var RightD = $FloorDetector/Right

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -SPEED

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if is_on_wall() or !LeftD.is_colliding() or !RightD.is_colliding():
		velocity.x *= -1
	
	velocity.y = move_and_slide(velocity, UP).y
