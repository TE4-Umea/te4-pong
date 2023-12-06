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
	if position.y < 0 or position.y > get_viewport_rect().size.y:
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
	
func element_effect(element):
	match element:
		"earth":
			element_earth()
		"spirit":
			element_spirit()

func element_earth():
	pass

func element_spirit():
	pass
