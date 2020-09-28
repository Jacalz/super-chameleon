extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 100
const GRAVITY = 1450

var velocity = Vector2()

onready var LeftD = $FloorDetector/Left
onready var RightD = $FloorDetector/Right
onready var ASprite = $AnimatedSprite
onready var PlayerR = $KillerInstinct/PlayerRight
onready var PlayerL = $KillerInstinct/PlayerLeft

var player_behind = false

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -SPEED

func turn() -> bool:
	return !LeftD.is_colliding() or !RightD.is_colliding()

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if is_on_wall() or turn():
		velocity.x *= -1

	if PlayerR.is_colliding() and velocity.x == -100:
		velocity.x *= -1
	elif PlayerL.is_colliding() and velocity.x == 100:
		velocity.x *= -1

	ASprite.flip_h = velocity.x == 100
	velocity.y = move_and_slide(velocity, UP).y


func _on_KillerInstinct_body_entered(body):
	if body.name == "Chameleon":
		if body.evolve_anim == "":
				get_tree().reload_current_scene()
		else:
			if !body.sees_enemy:
				 body.evolve_anim = ""
			else:
				queue_free()
			
