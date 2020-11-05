extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 1350

export var SPEED = 100 # Configurable speed

var velocity = Vector2()

onready var player = get_tree().get_root().find_node("Chameleon", true, false)

func _ready():
	set_physics_process(false)
	velocity.x = -SPEED
