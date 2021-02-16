extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 1350

export var SPEED = 100 # Configurable speed

var velocity = Vector2()

func _ready():
	set_physics_process(false)
	velocity.x = -SPEED
