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

func horizontal_move(right: bool):
	$AnimatedSprite.flip_h = right
	$AnimatedSprite.play("Walk")
	$AnimationPlayer.show()

func _physics_process(_delta: float) -> void:
	velocity.y = min(velocity.y + GRAVITY, TERMINAL_VELOCITY)
	
	var grndfriction = false
	
	# Horizontal movement for the player
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + HORIZONTAL_ACCELERATION, MAX_SPEED)
		horizontal_move(true)
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - HORIZONTAL_ACCELERATION, -MAX_SPEED)
		horizontal_move(false)
	else:
		$AnimatedSprite.play("Idle")
		$AnimationPlayer.hide()
		grndfriction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_HEIGHT
			$AnimationPlayer.show()
		if grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.3)
	else:
		if !grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.1)
	
	velocity = move_and_slide(velocity, UP)
