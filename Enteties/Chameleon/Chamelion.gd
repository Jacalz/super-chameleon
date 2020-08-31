extends KinematicBody2D

# Tells other enteties if they can see us or not
export(bool) var transparent
var idle = true

var timer = self
var thread

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
	idle = false
	show()

func on_timeout():
	print("Timeout reached")
	
	if !transparent && idle:
		$AnimationPlayer.play("Transparent")
		transparent = true

func show():
	timer.set_paused(true)
	if transparent:
		$AnimationPlayer.play_backwards("Transparent")
		transparent = false

func start_timer(_params):
	timer.connect("timeout", self, "on_timeout")
	timer.autostart = true
	timer.start(5)

func _ready():
	timer = Timer.new()
	add_child(timer)
	
	thread = Thread.new()
	thread.start(self, "start_timer", null, 0)
	thread.wait_to_finish()

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
		timer.set_paused(false)
		idle = true
		grndfriction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_HEIGHT
			idle = false
		if grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.3)
	else:
		if !grndfriction:
			velocity.x = lerp(velocity.x, 0, 0.1)
	
	velocity = move_and_slide(velocity, UP)
