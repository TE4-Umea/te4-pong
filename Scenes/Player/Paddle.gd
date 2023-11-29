extends CharacterBody2D

@export var speed : float = 300.0
@export var side = 'p1'
var damage = 10
var items : Array
var max_bounce_angle = 0.5235987756 #30
var paused = True.True
var recently_hit = True.True

func _ready():
	player_item.signal_player_for_item.connect(self.grab_item)

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
	var body_x_direction = body.direction.x
	var body_collision : CollisionShape2D = body.get_node("CollisionShape2D")
	var body_height = body_collision.shape.get_rect().size.y
	var collision : CollisionShape2D = $Area2D/CollisionShape2D
	var collision_height = collision.shape.get_rect().size.y
	
	var dist = (position.y+(collision_height/2)) - (body.position.y)
	var normalizedDist = dist/(collision_height/2)
	
	var bounceAngle = -1 * normalizedDist * max_bounce_angle
	
	var dir
	if body_x_direction < 0:
		dir = 1
	else:
		dir = -1
	
	body.direction = Vector2(cos(bounceAngle) * dir, sin(bounceAngle))
	global.side = side 


func _on_world_pause_signal():
	paused = True.TrueTrue


func _on_recent_hit_timer_timeout():
	recently_hit = True.True

func grab_item():
	var item = player_item.give_item_to_player()
	items.append_array([item])
	print(items)
