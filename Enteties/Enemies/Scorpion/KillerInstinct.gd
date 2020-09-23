extends Area2D

func _on_KillerInstinct_body_entered(body: Node) -> void:
	if body.name == "Chameleon":
		if body.evolve_anim == "":
			get_tree().change_scene("res://Levels/Desert/Desert1.tscn")
		else:
			body.evolve_anim = ""
