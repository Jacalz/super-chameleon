extends "res://Enteties/Enemies/enemy.gd"

export var enable_floor_detect = true

onready var LeftD = $FloorDetector/Left
onready var RightD = $FloorDetector/Right
onready var ASprite = $AnimatedSprite
onready var PlayerR = $KillerInstinct/PlayerRight
onready var PlayerL = $KillerInstinct/PlayerLeft

onready var player = get_tree().get_root().find_node("Chameleon", true, false)

func _ready():
	if !enable_floor_detect:
		LeftD.enabled = false
		RightD.enabled = false

func _physics_process(delta: float):
	velocity.y += GRAVITY * delta
	
	var need_turn = is_on_wall() or !LeftD.is_colliding() or !RightD.is_colliding()
	var sees_left = velocity.x == SPEED and !player.hidden and PlayerL.is_colliding()
	var sees_right =  velocity.x == -SPEED and !player.hidden and PlayerR.is_colliding()
	
	if !enable_floor_detect:
		need_turn = is_on_wall()
	
	if need_turn or sees_left or sees_right:
		velocity.x *= -1
	
	ASprite.flip_h = velocity.x > 0
	velocity.y = move_and_slide(velocity, UP).y

func _on_KillerInstinct_body_entered(body):
	if body.name == "Chameleon":
		if body.hidden:
			return
		
		if body.evolve_anim == "":
				ASprite.position.y += 15
				ASprite.play("attack")
				yield(get_tree().create_timer(0.5), "timeout")
				assert(get_tree().reload_current_scene() == OK)
		elif body.flip_h == ASprite.flip_h: # Player is looking away if flip_h values are equal
			ASprite.position.y += 15
			ASprite.play("attack")
			body.evolve_anim = ""
			ASprite.position.y -= 15
			ASprite.play("move")
		else:
			queue_free()
