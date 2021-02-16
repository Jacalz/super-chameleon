extends Area2D

func _on_EvolveBerry_body_entered(body):
	if body.name == "Chameleon":
		body._on_evolving()
		queue_free()
