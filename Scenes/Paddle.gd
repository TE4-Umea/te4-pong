extends CharacterBody2D

@export var speed : float = 300.0
@export var side = 'p1'
var paused = false

func _physics_process(delta):
	var direction
	if !paused:
		if side == 'p1':
			direction = get_axis('P1_UP', 'P1_DOWN')
		else:
			direction = get_axis('P2_UP', 'P2_DOWN')
		if direction:
			velocity.y = direction * speed
		else:
			velocity.y = move_toward(velocity.y, 0, speed)
		
		move_and_slide()

func get_axis(up, down):
	if Input.is_action_pressed(up): return -1
	elif Input.is_action_pressed(down): return 1


func _on_area_2d_body_entered(body):
	body.direction.x *= -1
	Main.side = side 


func _on_world_pause_signal():
	paused = true
