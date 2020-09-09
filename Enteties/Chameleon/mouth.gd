extends Area2D

export(String) var anim = ""

onready var timer = $Timer

func on_timeout():
	anim = ""

func _ready():
	timer.connect("timeout", self, "on_timeout")

func _process(delta):
	var areas = get_overlapping_areas()
	for area in areas:
		if area.name == "EvolveBerry":
			anim = "_evolved"
			timer.start()
			break
