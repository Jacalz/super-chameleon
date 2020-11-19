extends Control

var scene_path_to_load

const SAVE_DIR = "user://settings"
const SAVE_PATH = SAVE_DIR + "settings.dat"
var settings_data = {
	"fullscreen": false
} 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/CenterRow/Buttons/NewGame.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "on_Button_pressed", [button.scene_to_load])
	load_settings()

func on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	assert(get_tree().change_scene(scene_path_to_load) == OK)

func load_settings():
	var file = File.new()
	if file.file_exists(SAVE_PATH):
		var err = file.open(SAVE_PATH, File.READ)
		if err == OK:
			settings_data = file.get_var()
			file.close()
	
	OS.window_fullscreen = settings_data["fullscreen"]
