extends Control

var path = ""

const SAVE_DIR = "user://game_saves/"
const SAVE_PATH = SAVE_DIR + "save.dat"

func load_settings():
	var file = File.new()
	if file.file_exists(SAVE_PATH):
		var err = file.open(SAVE_PATH, File.READ)
		if err == OK:
			path = file.get_var()
			file.close()

func _ready():
	load_settings()
	if path == "" or path == "res://TitleScreen/TitleScreen.tscn":
		$CenterContainer/VBoxContainer/Button.disabled = true

func _on_Button_pressed():
	assert(get_tree().change_scene(path) == OK)
