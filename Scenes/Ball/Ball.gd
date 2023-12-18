extends CharacterBody2D
@export var speed : float = 300.0
var direction = Vector2.ZERO
var paused = false
var damage
var element = []
var direx = -1
var direxy = randf_range(-1.0, 1.0)
var image = preload("res://Assets/Img/B).png")
var lightning = 0
var water = 0
var earth = 0
var spirit = false
var element_sound = []

func _ready():

	for n in range(global.player_items_index.size()):
		if(global.player_items_index[n] == 5):
			lightning += 1
		if(global.player_items_index[n]==6):
			water += 1
		if(global.player_items_index[n]==8):
			earth += 1

	element_sound = AudioLoader.element_sound

	if(spirit):
		$AnimatedSprite2D.modulate = Color(1,0,1)
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
	for n in range(element.size()):
		element_effect(element[n])
	
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
		"lightning":
			element_lightning()

func element_lightning():

	if(randf_range(0, 1) > pow(0.66,lightning)):
		$LightningTimer.start()
		$ElementSoundEffect.stream = element_sound[2]
		$ElementSoundEffect.play()

		var player = get_tree().get_first_node_in_group("paddles")
		var enemy = get_tree().get_first_node_in_group("enemy")
		var line = Line2D.new()
		line.name = "lightning"
		#var texture = ImageTexture.create_from_image(image)
		#line.set_texture(texture)
		line.default_color = Color(0,1,1)
		#line.texture=ResourceLoader.load("res://Assets/Img/B).png")
		line.add_point(Vector2(-10,player.size.y/2))
		line.add_point(Vector2(enemy.position.x-position.x,enemy.position.y-position.y))
		player.add_child(line)
		get_tree().get_first_node_in_group("enemy").take_damage(10+damage)
		for n in range(element.size()):
			get_tree().get_first_node_in_group("enemy").element_effect(element[n])
		position.x = 50000

func element_light():
	$AnimatedSprite2D.modulate = Color(2,2,2)

func element_darkness():
	$AnimatedSprite2D.modulate = Color(.4,.4,.4)

func element_fire():
	$AnimatedSprite2D.modulate = Color(1,.3,.3)

func element_ice():
	$AnimatedSprite2D.modulate = Color(.5,.5,1)


func element_wind():
	$ElementSoundEffect.stream = element_sound[1]
	$ElementSoundEffect.play()
	speed *= 2

func element_water():
	if(randf_range(0, 1) > pow(0.66,water)):
		damage *= 3

func element_earth():
	$CollisionShape2D.set_scale(Vector2(2*(earth+1),2*(earth+1)))
	$AnimatedSprite2D.set_scale(Vector2(3*(earth+1),3*(earth+1)))
	speed *= pow(0.75,earth)

func element_spirit():
	for n in range(global.player_items_index.size()):
		if(global.player_items_index[n] == 7):
			$ElementSoundEffect.stream = element_sound[0]
			$ElementSoundEffect.play()
			get_tree().get_first_node_in_group("world").spawn_spirit_ball(position.x+25,position.y,direction.x,-direction.y + randf_range(-1, 1),damage/2)

func _on_lightning_timer_timeout():
	queue_free()
	if(get_tree().get_first_node_in_group("paddles").get_child_count()>3):
		var paddel = get_tree().get_first_node_in_group("paddles")
		paddel.get_child(paddel.get_child_count() - 1).queue_free()
