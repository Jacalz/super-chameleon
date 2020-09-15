extends Camera2D

const LOOK_AHEAD_FACTOR = 0.05
const TWEEN_DURATION = 1.0

onready var prev_pos = get_camera_position()
onready var tween = $ShiftTween

var facing = 0

func _check_facing():
	var new_facing = sign(get_camera_position().x - prev_pos.x)
	if new_facing != 0 && facing != new_facing:
		facing = new_facing
		var target_offset = get_viewport_rect().size.x * LOOK_AHEAD_FACTOR * facing
		
		tween.interpolate_property(self, "position:x", position.x, target_offset, TWEEN_DURATION, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.start()

func _process(delta):
	_check_facing()
	prev_pos = get_camera_position()

func _on_Chameleon_on_grounded_updated(is_grounded):
	drag_margin_v_enabled = !is_grounded
