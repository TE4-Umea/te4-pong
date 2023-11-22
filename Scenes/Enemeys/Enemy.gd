extends CharacterBody2D

var floating_text = preload("res://Scenes/Enemeys/floating_text.tscn")

@export var speed : float = 300.0
@export var enemy_name = "alexandro"
var weakness = "ljus"
var resistance = 10
var hp = 100
var damage = 10
var movement_speed = 300
var fire_rate = 10
var paused = false
var BULLET = preload("res://Scenes/Ball/Ball.tscn")

func shoot():
	print("shoot")
	owner.spawn_ball(owner.screensize.x -305, owner.screensize.y / 2)
	$Timer.wait_time = [0.5,1,2].pick_random()
	$Timer.start()

func take_damage(dmg):
	if dmg<hp:
		hp-=dmg
		$TextureProgressBar.value = hp
		var text = floating_text.instantiate()
		text.amount = dmg
		add_child(text)
	else:
		die()

func die():
	print("removing enemy")
	queue_free()


func _on_area_2d_body_entered(body):
	body.queue_free()
	take_damage(25)
	print(hp)


func _on_timer_timeout():
	shoot()
