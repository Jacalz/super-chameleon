extends "res://Enteties/Enemies/enemy.gd"

export var enable_floor_detect = true

onready var Floor = $FloorDetector
onready var Player = $KillerInstinct/Player
onready var ASprite = $AnimatedSprite

onready var player = get_tree().get_root().find_node("Chameleon", true, false)

func _ready():
	Floor.enabled = enable_floor_detect

func _physics_process(delta: float):
	velocity.y += GRAVITY * delta
	
	var need_turn = is_on_wall() or (Floor.enabled and !Floor.is_colliding()) # Collision returns false if disabled for some reason
	var sees_player = !player.hidden and Player.is_colliding()
	
	if !(need_turn == sees_player):
		velocity.x *= -1
		
		# Need to flip the detection on changing direction
		Floor.position.x = -Floor.position.x
		Player.rotation_degrees = -Player.rotation_degrees
		Player.position.x = -Player.position.x
	
	ASprite.flip_h = velocity.x > 0
	velocity.y = move_and_slide(velocity, UP).y

func _on_KillerInstinct_body_entered(body):
	if body.name == "Chameleon":
		if body.hidden:
			return
		
		if body.evolve_anim == "":
				ASprite.position.y += 15
				ASprite.play("attack")
				yield(get_tree().create_timer(0.5), "timeout")
				assert(get_tree().reload_current_scene() == OK)
		elif body.flip_h == ASprite.flip_h: # Player is looking away if flip_h values are equal
			ASprite.position.y += 15
			ASprite.play("attack")
			body.evolve_anim = ""
			ASprite.position.y -= 15
			ASprite.play("move")
		else:
			queue_free()
