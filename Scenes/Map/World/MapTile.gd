extends Area2D

@export var frames = []
var end_frame = 5

func _ready():
	$Sprite2D.frame = frames.pick_random()
