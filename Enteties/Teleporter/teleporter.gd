extends Area2D

export(String, FILE, "*.tscn") var scene_to_load

func _ready():
	z_index = 10

func _on_Teleporter_body_entered(body):
	if body.name == "Chameleon":
		get_tree().change_scene(scene_to_load)
