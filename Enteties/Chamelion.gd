extends KinematicBody2D

# Defines the up direction in the world.
const UP = Vector2(0, -1)

# Constants for defining how the chamelion can move
const GRAVITY = 10
const TERMINAL_VELOCITY = 600
const HORIZONTAL_ACCELERATION = 50
const MAX_SPEED = 300
const JUMP_HEIGHT = -400

# Velocity of our wonderful chamelion
var velocity = Vector2()

func _physics_process(delta: float) -> void:
	velocity.y = min(velocity.y + GRAVITY, TERMINAL_VELOCITY)
	
	var grndfriction = false
	
	# Movement for the player
	if Input.is_action_pressed("move_right"):
		velocity.x = min(velocity.x + HORIZONTAL_ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("move_left"):
		velocity.x = max(velocity.x - HORIZONTAL_ACCELERATION, -MAX_SPEED)
	else:
		grndfriction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_HEIGHT
		if grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.3)
	else:
		if !grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.1)
	
	velocity = move_and_slide(velocity, UP)
