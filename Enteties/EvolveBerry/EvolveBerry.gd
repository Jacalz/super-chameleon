extends Area2D

signal on_eaten
var hidden = false

func _on_EvolveBerry_body_entered(body):
	if body.name == "Chameleon" && !hidden:
		emit_signal("on_eaten")
		hidden = true
		hide()
