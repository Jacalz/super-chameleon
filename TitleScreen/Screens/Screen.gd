extends Control

func _on_Button_pressed():
	assert(get_tree().change_scene("res://TitleScreen/TitleScreen.tscn") == OK)

func _on_PlayDesert_pressed():
	assert(get_tree().change_scene("res://Levels/Desert/Desert1.tscn") == OK)

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_Button_pressed()
