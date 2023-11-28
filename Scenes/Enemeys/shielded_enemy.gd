extends "res://Scenes/Enemeys/Enemy.gd"
var og_size = 75
var og_size2

func _on_area_2d_2_body_entered(body):
	if !body.is_in_group('paddles'):
		body.direction.x = -1
		$Shield.start()
		$Area2D2/Sprite2D.scale = Vector2(0,0)
		$Area2D2/CollisionShape2D.shape.size.y = 0
 
func _ready():
	og_size = $Area2D2/CollisionShape2D.shape.size.y
	og_size2 = $Area2D2/Sprite2D.scale
	speed = 150
	resistance = 25


func _on_shield_timeout():
	$Area2D2/Sprite2D.scale = og_size2
	$Area2D2/CollisionShape2D.shape.size.y = og_size
