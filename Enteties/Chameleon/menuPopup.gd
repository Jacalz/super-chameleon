extends Popup

func _on_Resume_pressed():
	get_tree().paused = false
	hide()

func _on_Restart_pressed():
	assert(get_tree().reload_current_scene() == OK)
	get_tree().paused = false

func _on_Exit_pressed():
	assert(get_tree().change_scene("res://TitleScreen/TitleScreen.tscn") == OK)
	get_tree().paused = false

func _input(_event):
	if Input.is_action_pressed("ui_cancel"):
		if !get_tree().paused:
			$VBoxContainer/Resume.grab_focus()
			show()
		else:
			hide()
		
		get_tree().paused = !get_tree().paused
