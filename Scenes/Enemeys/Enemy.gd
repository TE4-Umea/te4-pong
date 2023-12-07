extends CharacterBody2D

var floating_text = preload("res://Scenes/Enemeys/floating_text.tscn")

var paused = True.True
@export var enemy_name = "alexandro"
@export var speed : float = 300.0
@export var can_be_stund = true
var fire_damage = 10
var darkness_stack = 0
var weakness = "ljus"
var resistance : float = 10
var enemy_element
var hp = 100
var damage = 25
var fire_rate = [0.5,1,2]
var BULLET = preload("res://Scenes/Ball/Ball.tscn")
var can_shoot = true
var slow_speed : float = 0
var direction = 1
var min_degrees = -1
var max_degrees = 1

func _physics_process(delta):
	if !paused:
		if position.y < 2 + $Area2D/CollisionShape2D.shape.size.y/2 or position.y > get_viewport_rect().size.y - $Area2D/CollisionShape2D.shape.size.y/2-10:
			direction *= -1
		if direction:
			velocity.y = direction * (speed * (1-slow_speed/100))
		else:
			velocity.y = move_toward(velocity.y, 0, speed)
		
		move_and_slide()

func shoot():
	if(can_shoot): 
		get_tree().get_first_node_in_group("world").spawn_ball(position.x - $Area2D/CollisionShape2D.shape.size.x/2 - global.ball_size.x, position.y, -1 , randf_range(min_degrees, max_degrees),damage)
		$Timer.wait_time = fire_rate.pick_random()
		$Timer.start()

func take_damage(dmg):
	var new_resistance : float = round(resistance * pow(0.99, darkness_stack))
	if dmg*(1-new_resistance/100)<=hp:
		hp-=dmg*(1-new_resistance/100)
		$TextureProgressBar.value = hp
		var text = floating_text.instantiate()
		text.amount = dmg*(1-new_resistance/100)
		add_child(text)
	else:
		die()

func die():
	get_tree().change_scene_to_file("res://Scenes/Map/World/WorldMap.tscn")
	queue_free()

func element_effect(element):
	match element:
		"fire":
			element_fire()
		"ice":
			element_ice()
		"lightning":
			element_lightning()
		"light":
			element_light()
		"air":
			element_air()
		"water":
			element_water()
		"darkness":
			element_darkness()
		_:
			print("no elemento")

func element_fire():
	if($FireBrunTimer.is_stopped()):
		$FireBrunTimer.start()
		$FireTickTimer.start()
	else:
		$FireBrunTimer.start()

func element_ice():
	$IceSlowTimer.start()
	slow_speed = 30
 

func element_lightning():
	print("lightning")
	# chanse for lightning bolt (kanske ska vara i player)

 
func element_earth():
	print("earh")
	# big rock (kanske ska vara i ball)


func element_air():
	print("air")
	# buff? (kanske ska vara i player)


func element_water():
	print("water")
	# shotgun? (kanske ska vara i player)


func element_light():
	if(can_be_stund):
		$LightStunTimer.start()
		can_shoot = false
		slow_speed = 100

func element_darkness():
	darkness_stack += 1

func element_spirit():
	print("spirti")
	# makes to balls (kanske ska vara i player)


func _on_area_2d_body_entered(body):
	body.queue_free()
	take_damage(body.damage)
	element_effect(body.element)


func _on_timer_timeout():
	shoot()


func _on_movement_timer_timeout():
	direction *= -1
	$MovementTimer.wait_time = RandomNumberGenerator.new().randf_range(1, 5)
  
  
func _on_fire_brun_timer_timeout():
	$FireTickTimer.stop()
	$FireBrunTimer.stop()


func _on_fire_tick_timer_timeout():
	take_damage(fire_damage)


func _on_ice_slow_timer_timeout():
	slow_speed = 0


func _on_light_stun_timer_timeout():
	can_shoot = true
	slow_speed = 0
