extends Button

export(String, FILE, "*.tscn") var scene_to_load # Needs to conform to MenuButton

func _on_MenuButton_pressed():
	get_tree().quit()
