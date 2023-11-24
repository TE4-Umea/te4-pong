extends Node2D

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var map_steps = []

@export var steps = 40
@export var step_size = 16

# Called when the node enters the scene tree for the first time.
func _ready():
	_generate_map()


func _generate_map():
	map_steps.append(position)
	var last_dir = Vector2.ZERO
	var steps_in_dir = 0
	var step = 1
	while step < steps:
		var dir = DIRECTIONS.pick_random()
		if last_dir == dir:
			steps_in_dir += 1
			if steps_in_dir >= 2:
				steps_in_dir = 0
				dir *= -1
		position = position + dir * step_size
		if position not in map_steps:
			map_steps.append(position)
			step += 1
		last_dir = dir

func _draw():
	position = Vector2.ZERO
	for step in map_steps:
		draw_rect(Rect2(step.x, step.y, step_size, step_size), Color.AQUAMARINE, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
