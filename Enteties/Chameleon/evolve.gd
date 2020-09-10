extends Node2D

onready var evolveberry = get_tree().get_root().find_node("EvolveBerry", true, false).connect("on_eaten", self, "evolve")
onready var timer = $Timer

signal on_evolving

func evolve():
	emit_signal("on_evolving")
	timer.start()
