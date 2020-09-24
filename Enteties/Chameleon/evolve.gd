extends Node2D

onready var berries = get_tree().get_root().find_node("Berries", true, false)
onready var timer = $Timer
onready var player = $Unevolve

signal on_evolving

func _ready():
	for berry in berries.get_children():
		berry.connect("on_eaten", self, "evolve")

func evolve():
	emit_signal("on_evolving")
	timer.start()

