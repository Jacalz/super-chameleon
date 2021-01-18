extends Area2D

export(String, FILE, "*.tscn") var scene_to_load

const SAVE_DIR = "user://game_saves/"
const SAVE_PATH = SAVE_DIR + "save.dat"

func save_level(settings):
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var err = file.open(SAVE_PATH, File.WRITE)
	if err == OK:
		file.store_var(settings)
		file.close()

func _on_Teleporter_body_entered(body):
	if body.name == "Chameleon":
		save_level(scene_to_load)
		assert(get_tree().change_scene(scene_to_load) == OK)
