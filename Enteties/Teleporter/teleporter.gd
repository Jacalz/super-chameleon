extends Area2D

export(String, FILE, "*.tscn") var scene_to_load

func _on_Teleporter_body_entered(body):
	if body.name == "Chameleon":
		assert(get_tree().change_scene(scene_to_load) == OK)
