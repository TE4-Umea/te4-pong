extends CharacterBody2D
@export var speed : float = 300.0
var direction = Vector2.ZERO
var paused = false

func _ready():
	direction.y = [1, -1].pick_random()
	direction.x = [1, -1].pick_random()

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
