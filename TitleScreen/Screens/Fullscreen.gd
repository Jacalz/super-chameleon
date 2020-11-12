extends CheckBox

func _ready():
	grab_focus()

func _on_Fullscreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
