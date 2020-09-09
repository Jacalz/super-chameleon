extends KinematicBody2D

# Onready variables for our nodes
onready var sprite = $AnimatedSprite
onready var camo = $Camouflage
onready var evolve = $Mouth

# Defines the up direction in the world.
const UP = Vector2(0, -1)

# Constants for defining how the chameleon can move
const GRAVITY = 1000
const TERMINAL_VELOCITY = 600
const HORIZONTAL_SPEED = 7 * 64
const JUMP_HEIGHT = -7 * 64

# Velocity of our wonderful chameleon
var velocity = Vector2()

func horizontal_move(direction: int):
	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	sprite.play("Walk" + evolve.anim)
	
	camo.disable()

func get_horizontal_input() -> int:
	return -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))

func _input(event):
	if is_on_floor() && event.is_action("ui_up"):
		velocity.y = JUMP_HEIGHT
		camo.disable()

func _physics_process(delta: float):
	velocity.y = min(velocity.y + GRAVITY * delta, TERMINAL_VELOCITY)
	
	var grndfriction = false
	
	var direction = get_horizontal_input()
	if direction != 0:
		velocity.x = lerp(velocity.x, HORIZONTAL_SPEED * direction, 0.2)
		horizontal_move(direction)
	else:
		sprite.play("Idle" + evolve.anim)
		camo.enable()
		grndfriction = true
	
	if is_on_floor():
		if grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.3)
	else:
		sprite.play("Jump" + evolve.anim)

		if !grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.1)
	
	velocity = move_and_slide(velocity, UP)
