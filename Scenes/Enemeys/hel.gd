extends "res://Scenes/Enemeys/Enemy.gd"
var ENEMY = preload("res://Scenes/Enemeys/fast_enemy.tscn")
var stage = 1

func spawn_minion():
	var enemy =  ENEMY.instantiate()
	enemy.global_position = Vector2(position.x - $Area2D/CollisionShape2D.shape.size.x/2 - global.ball_size.x, position.y)
	owner.add_child(enemy)

func _ready():
	resistance = 75
	fire_rate = [0.5,1,2]
	min_degrees = -1
	max_degrees = 1
	damage = 25

func take_damage(dmg):
	var new_resistance : float = round(resistance * pow(0.99, darkness_stack))
	if dmg*(1-new_resistance/100)<hp:
		hp-=dmg*(1-new_resistance/100)
		$TextureProgressBar.value = hp
		var text = floating_text.instantiate()
		text.amount = dmg*(1-new_resistance/100)
		add_child(text)
	else:
		if(stage==1):
			stage+=1
			resistance = 95
			hp = 100
			$TextureProgressBar.value = hp
			$TextureProgressBar.tint_progress = Color("#0000ff")
			fire_rate = [0.05]
			min_degrees = 0
			max_degrees = 0
			damage = 5
		else:
			die()

func die():
	$EnemyDead.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	$EnemyDead.play()
	hide()
	get_tree().paused = true
	get_tree().get_first_node_in_group("item_select").boss = true
	get_tree().get_first_node_in_group("item_selection").show()
	#get_tree().change_scene_to_file("res://Scenes/Map/World/WorldMap.tscn")

func _on_enemy_dead_finished():
	queue_free()


func shoot():
	get_tree().get_first_node_in_group("world").spawn_ball(position.x - $Area2D/CollisionShape2D.shape.size.x/2 - global.ball_size.x, position.y, -1 , randf_range(min_degrees, max_degrees),damage)
	$Timer.wait_time = fire_rate.pick_random()
	$Timer.start()


func _on_timer_2_timeout():
	return
	#spawn_minion()


