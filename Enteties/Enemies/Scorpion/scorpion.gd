extends "res://Enteties/Enemies/enemy.gd"

onready var LeftD = $FloorDetector/Left
onready var RightD = $FloorDetector/Right
onready var ASprite = $AnimatedSprite
onready var PlayerR = $KillerInstinct/PlayerRight
onready var PlayerL = $KillerInstinct/PlayerLeft

func _physics_process(delta: float):
	velocity.y += GRAVITY * delta
	
	var need_turn = is_on_wall() or !LeftD.is_colliding() or !RightD.is_colliding()
	var sees_left = velocity.x == SPEED and !player.hidden and PlayerL.is_colliding()
	var sees_right =  velocity.x == -SPEED and !player.hidden and PlayerR.is_colliding()
	
	if sees_left or sees_right or need_turn:
		velocity.x *= -1
	
	ASprite.flip_h = velocity.x == SPEED
	velocity.y = move_and_slide(velocity, UP).y

func _on_KillerInstinct_body_entered(body):
	if body.name == "Chameleon":
		if body.evolve_anim == "" and !body.hidden:
				ASprite.position.y += 15
				ASprite.play("attack")
				yield(get_tree().create_timer(0.5), "timeout")
				assert(get_tree().reload_current_scene() == OK)
		else:
			if !body.sees_enemy and !body.hidden:
				 body.evolve_anim = ""
			elif !body.hidden:
				queue_free()
