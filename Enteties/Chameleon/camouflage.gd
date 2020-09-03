extends AnimationPlayer

# Tells other enteties if they can see us or not
export(bool) var camouflaged

export var idle = true
var timer = self
var thread = self

func on_timeout():
	if !camouflaged && idle:
		play("Transparent")
		camouflaged = true

func show():
	idle = true
	
	timer.set_paused(true)
	if camouflaged:
		play_backwards("Transparent")
		camouflaged = false

func hide():
	timer.set_paused(false)
	idle = true

func start_timer(_params):
	timer.connect("timeout", self, "on_timeout")
	timer.autostart = true
	timer.start(5)

func _ready():
	timer = Timer.new()
	add_child(timer)
	
	thread = Thread.new()
	thread.start(self, "start_timer", null, 0)
	thread.wait_to_finish()
