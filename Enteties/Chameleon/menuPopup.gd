extends Popup

func _on_Restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_Exit_pressed():
	get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")
	get_tree().paused = false

func _on_Resume_pressed():
	get_tree().paused = false
	hide()
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if !get_tree().paused:
			show()
		else:
			hide()
		
		get_tree().paused = !get_tree().paused
