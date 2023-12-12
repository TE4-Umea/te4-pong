extends "res://Scenes/Enemeys/Enemy.gd"

func _ready():
	size = $CollisionShape2D.shape.size
	speed = 600
	resistance = 0
