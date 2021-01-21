extends "res://Enteties/Enemies/enemy.gd"

onready var LeftD = $FloorDetector/Left
onready var RightD = $FloorDetector/Right
onready var ASprite = $AnimatedSprite
onready var PlayerR = $KillerInstinct/PlayerRight
onready var PlayerL = $KillerInstinct/PlayerLeft

func _physics_process(delta: float):
	velocity.y += GRAVITY * delta
	
	var need_turn = is_on_wall() or !LeftD.is_colliding() or !RightD.is_colliding()
	var sees_left = velocity.x == SPEED and !player.hidden and PlayerL.is_colliding()
	var sees_right =  velocity.x == -SPEED and !player.hidden and PlayerR.is_colliding()
	
	if sees_left or sees_right or need_turn:
		velocity.x *= -1
	
	ASprite.flip_h = velocity.x == SPEED
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
			body.evolve_anim = ""
		else:
			queue_free()
