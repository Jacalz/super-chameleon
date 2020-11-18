extends "res://Enteties/Enemies/enemy.gd"

onready var ASprite = $AnimatedSprite

func _physics_process(delta: float):
	velocity.y += GRAVITY * delta
	
	if is_on_wall():
		velocity.x *= -1
	
	ASprite.flip_h = velocity.x == SPEED
	velocity.y = move_and_slide(velocity, UP).y

func _on_KillerInstinct_body_entered(body):
	if body.name == "Chameleon":
		if body.evolve_anim == "" and !body.hidden:
				ASprite.position.y += 15
				ASprite.play("attack")
				yield(get_tree().create_timer(0.5), "timeout")
				get_tree().reload_current_scene()
		else:
			if !body.sees_enemy and !body.hidden:
				 body.evolve_anim = ""
			elif !body.hidden:
				queue_free()
