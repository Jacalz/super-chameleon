extends KinematicBody2D

var is_grounded = true
signal on_grounded_updated(is_grounded)

# Onready variables for our nodes
onready var sprite = $AnimatedSprite
onready var camo = $Camouflage
onready var evolve = $Evolve
onready var shape = $CollisionShape2D.shape

var hidden = false

# Defines the up direction in the world.
const UP = Vector2(0, -1)

# Constants for defining how the chameleon can move
const GRAVITY = 1350
const TERMINAL_VELOCITY = 800
const HORIZONTAL_SPEED = 7 * 64
const JUMP_HEIGHT = -10 * 64

# Velocity of our wonderful chameleon
var velocity = Vector2()

var evolve_anim = ""
var flip_h = true

func _on_Evolve_timeout():
	shape.height = 45
	evolve_anim = ""

func _on_evolving():
	shape.height = 65
	evolve_anim = "_evolved"

func horizontal_move(direction: int):
	if direction != 0:
		sprite.flip_h =  direction > 0
	sprite.play("Walk" + evolve_anim)
	
	camo.disable()

func get_horizontal_input() -> float:
	return -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")

func _input(event):
	if is_on_floor() && event.is_action_pressed("move_jump"):
		velocity.y = JUMP_HEIGHT
		camo.disable()

func _physics_process(delta: float):
	velocity.y = min(velocity.y + GRAVITY * delta, TERMINAL_VELOCITY)
	
	var grndfriction = false
	hidden = camo.camouflaged
	flip_h = sprite.flip_h
	
	# Restart level if the player falls off the platforms
	if global_position.y > 650:
		assert(get_tree().reload_current_scene() == OK)
		
	var direction = get_horizontal_input()
	if direction != 0:
		velocity.x = lerp(velocity.x, HORIZONTAL_SPEED * direction, 0.2)
		horizontal_move(direction)
	else:
		sprite.play("Idle" + evolve_anim)
		camo.enable()
		grndfriction = true
	
	if is_on_floor():
		if grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.35)
	else:
		sprite.play("Jump" + evolve_anim)

		if !grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.095)
	
	velocity = move_and_slide(velocity, UP)
	
	var was_grounded = is_grounded
	is_grounded = is_on_floor()
	
	if was_grounded == null || is_grounded != was_grounded:
		emit_signal("on_grounded_updated", is_grounded)
