extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body.name == "Chameleon":
		if body.evolve_anim == "":
			yield(get_tree().create_timer(0.25), "timeout")
			assert(get_tree().reload_current_scene() == OK)
		else:
			 body.evolve_anim = ""
