extends "res://Scenes/Enemeys/Enemy.gd"

func _on_area_2d_2_body_entered(body):
	if !body.is_in_group('paddles'):
		body.direction.x = -1
 
func _ready():
	speed = 150
	resistance = 25
