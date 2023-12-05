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
	screensize = get_viewport().get_visible_rect().size

func _on_norr_body_entered(body):
	if body.is_in_group('ball'):
		body.direction.y *= -1

func _on_bottom_body_entered(body):
	if body.is_in_group('ball'):
		body.direction.y *= -1



func _on_kanye_body_entered(body):
	global.player_hp -= 25
	$ProgressBar.value = global.player_hp
	await get_tree().create_timer(1).timeout
	
	body.queue_free()
	if global.player_hp < 1:
		$Control/Label3.text = ("du dog :c")
		pauseGame()

func _on_left_body_entered(body):#!left
	global.p1_score = 1
	
	await get_tree().create_timer(1).timeout
	
	body.queue_free()
	if global.p1_score >= maxScore:
		$Control/Label3.text = ("Player 1 won")
		pauseGame()
	

func pauseGame():
	$Control/Label3.visible = true
	$Control/PlayAgain.visible = true
	$Control/MainMenu.visible = true
	pauseSignal.emit()

func _on_play_again_pressed():
	global.player_hp = 100
	global.p1_score = 0
	global.p2_score = 0
	get_tree().change_scene_to_file("res://Scenes/Map/World.tscn")


func _on_main_menu_pressed():
	global.player_hp = 100
	global.p1_score = 0
	global.p2_score = 0
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
