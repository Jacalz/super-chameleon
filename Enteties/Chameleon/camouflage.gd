extends AnimationPlayer

# Tells other enteties if they can see us or not
export(bool) var camouflaged

onready var timer = $Timer

func on_timeout():
	if !camouflaged:
		play("Transparent")
		camouflaged = true

func disable():
	timer.stop()
	
	if camouflaged:
		play_backwards("Transparent")
		camouflaged = false

func enable():
	if timer.is_stopped():
		timer.start()

func _ready():
	timer.connect("timeout", self, "on_timeout")
