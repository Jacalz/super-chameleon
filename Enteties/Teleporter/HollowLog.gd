extends StaticBody2D

export var flipped = true

func _ready():
	$Background.flip_h = flipped
	$Foreground.flip_h = flipped
	
	if !flipped:
		$Wall.position.x = -62
