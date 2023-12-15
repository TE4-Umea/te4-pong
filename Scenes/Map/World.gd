extends Node
var screensize
@export var maxScore = 11
signal pauseSignal
var BALL = preload("res://Scenes/Ball/Ball.tscn")
var shift = false

func spawn_ball(x,y,direx,direxy,damage):
	var ball =  BALL.instantiate()
	ball.global_position = Vector2(x,y)
	ball.direx = direx
	ball.direxy = direxy
	ball.damage = damage
	add_child(ball)

# Called when the node enters the scene tree for thesss first time.
func _ready():
	$Music.stream = AudioLoader.enemy_battle_music[0]
	$Music.play(1)
	
	$ProgressBar.value = global.player_hp
	var enemy
	if global.is_boss:
		enemy = global.boss.instantiate()
	else:
		enemy = global.enemy.instantiate()
	add_child(enemy)
	enemy.position = $Spawner.position
	screensize = get_viewport().get_visible_rect().size

func _on_norr_body_entered(body):
	if body.is_in_group('ball'):
		body.direction.y *= -1
		body.get_node( "AnimatedSprite2D" ).rotation_degrees = 0

func _on_bottom_body_entered(body):
	if body.is_in_group('ball'):
		body.direction.y *= -1
		body.get_node( "AnimatedSprite2D" ).rotation_degrees = 0


func _on_kanye_body_entered(body):
	$PlayerTakeDmage.play()
	global.player_hp -= 25
	$ProgressBar.value = global.player_hp
#	await get_tree().create_timer(1).timeout
	
	body.queue_free()
	if global.player_hp < 1:
		global.player_items_copy = []
		global.player_items_index = []
		$Control/Label3.text = ("you died :c")
		pauseGame()
		$GameOver.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		$GameOver.play()
		get_tree().paused = true

func _on_left_body_entered(body):#!left
	global.p1_score = 1
	
#	await get_tree().create_timer(1).timeout
	
	body.queue_free()
	if global.p1_score >= maxScore:
		$Control/Label3.text = ("Player 1 won")
		pauseGame()
	

func pauseGame():
	$Control/Label3.visible = true
	$Control/Label3.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	$Control/PlayAgain.visible = false
	$Control/PlayAgain.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	$Control/MainMenu.visible = true
	$Control/MainMenu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	pauseSignal.emit()

func _on_play_again_pressed():
	get_tree().paused = false
	global.player_hp = 100
	global.p1_score = 0
	global.p2_score = 0
	get_tree().change_scene_to_file("res://Scenes/Map/World.tscn")


func _on_main_menu_pressed():
	get_tree().paused = false
	global.player_hp = 100
	global.p1_score = 0
	global.p2_score = 0
	MapManager.current_map = []
	MapManager.current_world = null
	MapManager.current_layout = []
	MapManager.saved = false
	MapManager.node_state = []
	MapManager.chosen_state = []
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_stamina_timer_timeout():
	if shift and $ProgressBar2.value > 0:
		$p1.speed = 1000
		$ProgressBar2.value -= 5
	else:
		shift = false
		$p1.speed = 500
		$ProgressBar2.value += 1

func _input(event):
	if event.is_action_pressed("Shift"):
		if $ProgressBar2.value > 25:
			$p1.speed = 1000
			shift = true
	elif event.is_action_released("Shift"):
		$p1.speed = 500
		shift = false
