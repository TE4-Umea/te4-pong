extends CharacterBody2D
@export var speed : float = 300.0
var direction = Vector2.ZERO
var paused = false
var damage
var element
var direx = -1
var direxy = randf_range(-1.0, 1.0)

func _ready():
	global.ball_size = $CollisionShape2D.shape.size
	direction.y = direxy
	direction.x = direx
	$AnimatedSprite2D.rotation_degrees = rad_to_deg(direction.x*direction.y)-90*direction.x

func _process(delta):
	if position.y < 2 + $CollisionShape2D.shape.size.y/2 or position.y > get_viewport_rect().size.y - $CollisionShape2D.shape.size.y/2-10:
		direction.y *= -1
		if(direction.x == -1):
			$AnimatedSprite2D.rotation_degrees = rad_to_deg(direction.x*direction.y)-90*direction.x
		else:
			$AnimatedSprite2D.rotation_degrees = rad_to_deg(direction.x*direction.y)-90

func _physics_process(delta):
	if !paused:
		if direction:
			velocity = direction.normalized() * speed
		else:
			velocity = velocity.move_toward(Vector2.ZERO, speed)
		move_and_slide()

func _on_world_pause_signal():
	paused = true

func collided_with_player(player_damage, player_element):
	damage = player_damage
	element = player_element
	element_effect(element)
	
func element_effect(element):
	match element:
		"earth":
			element_earth()
		"spirit":
			element_spirit()
		"water":
			element_water()
		"wind":
			element_wind()
		"fire":
			element_fire()
		"ice":
			element_ice()
		"darkness":
			element_darkness()
		"light":
			element_light()

func element_light():
	$AnimatedSprite2D.modulate = Color(2,2,2)

func element_darkness():
	$AnimatedSprite2D.modulate = Color(.4,.4,.4)

func element_fire():
	$AnimatedSprite2D.modulate = Color(1,.3,.3)

func element_ice():
	$AnimatedSprite2D.modulate = Color(.5,.5,1)


func element_wind():
	speed *= 2

func element_water():
	damage *= [1,3].pick_random()

func element_earth():
	$CollisionShape2D.set_scale(Vector2(4,4))
	$AnimatedSprite2D.set_scale(Vector2(6,6))
	speed *= .75

func element_spirit():
	print("sprit")
	print(owner)
	$AnimatedSprite2D.modulate = Color(1,0,1)
	get_tree().get_first_node_in_group("world").spawn_ball(position.x+25,position.y,direction.x,-direction.y,damage/2)
	pass
