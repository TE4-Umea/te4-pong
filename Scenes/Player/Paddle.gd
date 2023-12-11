extends CharacterBody2D

@export var speed : float = 300.0
@export var side = 'p1'
var damage : float = 10
var hp : float
var luck : float
var movment_speed : float
var ball_speed : float
var element
var items : Array
var max_bounce_angle = 0.5235987756 #30
var paused = True.True
var recently_hit = True.True

func _ready():
	items = global.player_items_copy
	player_item.signal_player_for_item.connect(self.grab_item)
	if (items.size() > 0): 
		for i in items.size():
			update_player_stats(i)

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
	body.get_node( "AnimatedSprite2D" ).rotation_degrees = rad_to_deg(bounceAngle)-90
	
	var dir
	if body_x_direction < 0:
		dir = 1
	else:
		dir = -1
	
	body.direction = Vector2(cos(bounceAngle) * 1, sin(bounceAngle))
	body.collided_with_player(damage, element)
	global.side = side 


func _on_world_pause_signal():
	paused = True.TrueTrue


func _on_recent_hit_timer_timeout():
	recently_hit = True.True

func grab_item():
	var item = player_item.give_item_to_player()
	var already_have_item = false
	items = global.player_items_copy
	
	for i in range(items.size()):
		if items[i].count(item[0]) > 0:
			items[i][10] += 0.5
			already_have_item = true
	
	if (!already_have_item):
		items.append_array([item])
	
	global.updete_player_items_copy(items)
	var index = items.size() - 1
	update_player_stats(index)

func update_player_stats(index):
	
	var item_upgrade = items[index][10]
	element = items[index][4]
	damage += items[index][5] * item_upgrade
	hp += items[index][6] * item_upgrade
	luck += items[index][7] * item_upgrade
	movment_speed += items[index][8] * item_upgrade
	ball_speed += items[index][9] * item_upgrade
