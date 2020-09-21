extends Area2D

signal on_eaten

func _on_EvolveBerry_body_entered(body):
	if body.name == "Chameleon":
		emit_signal("on_eaten")
		queue_free()
