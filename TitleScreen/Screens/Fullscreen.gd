extends CheckBox

const SAVE_DIR = "user://settings"
const SAVE_PATH = SAVE_DIR + "settings.dat"

var settings_data = {
	"fullscreen": false
} 

func _ready():
	grab_focus()
	load_settings()
	
func load_settings():
	var file = File.new()
	if file.file_exists(SAVE_PATH):
		var err = file.open(SAVE_PATH, File.READ)
		if err == OK:
			settings_data = file.get_var()
			file.close()
	
	OS.window_fullscreen = settings_data["fullscreen"]
	pressed = OS.window_fullscreen

func save_settings(settings):
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var err = file.open(SAVE_PATH, File.WRITE)
	if err == OK:
		file.store_var(settings)
		file.close()
	
func _on_Fullscreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	settings_data["fullscreen"] = button_pressed
	save_settings(settings_data)
	
