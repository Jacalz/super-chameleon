extends "res://Enteties/Enemies/enemy.gd"

onready var ASprite = $AnimatedSprite

func _physics_process(delta: float):
	velocity.y += GRAVITY * delta
	
	if is_on_wall():
		velocity.x *= -1
	
	if global_position.y > 600:
		queue_free()
	
	ASprite.flip_h = velocity.x == -SPEED
	velocity.y = move_and_slide(velocity, UP).y

func _on_Area2D_body_entered(body):
	if body.name == "Chameleon":
		if body.evolve_anim == "" and !body.hidden:
				ASprite.play("block")
				yield(get_tree().create_timer(0.5), "timeout")
				assert(get_tree().reload_current_scene() == OK)
		else:
			if !body.sees_enemy and !body.hidden:
				 body.evolve_anim = ""
			elif !body.hidden:
				queue_free()
