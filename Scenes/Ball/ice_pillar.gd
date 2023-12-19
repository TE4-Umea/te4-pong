extends "res://Scenes/Ball/Ball.gd"

func _ready():
	global.ball_size = $CollisionShape2D.shape.size
	direction.y = 0
	direction.x = -1
