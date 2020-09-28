extends MarginContainer

export var debug = false

onready var fps = $HBoxContainer/VBoxContainer/FPS
onready var memory = $HBoxContainer/VBoxContainer/Memory

func _process(_delta: float) -> void:
	if debug:
		fps.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))
		memory.text = "Static memory: " + str(round(Performance.MEMORY_STATIC) * 0.000001) + " MB"
