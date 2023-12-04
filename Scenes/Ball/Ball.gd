extends CharacterBody2D
@export var speed : float = 300.0
var direction = Vector2.ZERO
var paused = false
var direx = -1
var direxy = randf_range(-1.0, 1.0)
var damage = 0

func _ready():
	global.ball_size = $CollisionShape2D.shape.size
	direction.y = direxy
	direction.x = direx

func _process(delta):
	if position.y < 0 or position.y > get_viewport_rect().size.y:
		direction.y *= -1

func _physics_process(delta):
	if !paused:
		if direction:
			velocity = direction.normalized() * speed
		else:
			velocity = velocity.move_toward(Vector2.ZERO, speed)
		move_and_slide()

func _on_world_pause_signal():
	paused = true

func collided_with_player(player_damage):
	print("collided_with_player")
	damage = player_damage
