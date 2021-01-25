extends "res://Enteties/Enemies/enemy.gd"

onready var ASprite = $AnimatedSprite

func _physics_process(delta: float):
	velocity.y += GRAVITY * delta
	
	if is_on_wall() and ASprite.animation != "block":
		velocity.x *= -1
	
	# Remove the lizard if it falls out of the world
	if global_position.y > 700:
		queue_free()
	
	ASprite.flip_h = velocity.x == -SPEED
	velocity.y = move_and_slide(velocity, UP).y

func _on_Area2D_body_entered(body):
	if body.name == "Chameleon":
		if body.hidden:
				return
		
		if body.evolve_anim == "":
				velocity.x = 0
				ASprite.play("block")
				yield(get_tree().create_timer(0.5), "timeout")
				assert(get_tree().reload_current_scene() == OK)
		elif body.flip_h != ASprite.flip_h: # Player is looking away if flip_h values are not equal
			ASprite.play("block")
			body.evolve_anim = ""
			ASprite.play("move")
		else:
			queue_free()
