extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")

func _on_PlayDesert_pressed():
	get_tree().change_scene("res://Levels/Desert/Desert1.tscn")

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_Button_pressed()
