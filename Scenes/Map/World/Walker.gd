extends Node2D

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

signal done_with_map

var map_steps = []
var map_position = Vector2.ZERO

@export var steps = 40
@export var step_size = 16

# Called when the node enters the scene tree for the first time.
func _ready():
	_generate_map()


func _generate_map():
	map_steps.append(map_position)
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
		map_position = map_position + dir
		if map_position not in map_steps:
			map_steps.append(map_position)
			step += 1
		last_dir = dir
	done_with_map.emit(map_steps)
