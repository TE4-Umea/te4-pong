extends Marker2D
const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

@export var length : int = 3
@export var x_gap : int = 128
@export var y_gap : int = 192
@export var steps = 10



@onready var map_node : PackedScene = preload("res://Scenes/Map/OverWorld/Map_Node.tscn")

var point_position
var positions_to_draw : Array[Vector2] = []
var create_new_maps = false
var index
var map_steps = []
var map_position = Vector2.ZERO

func _ready():
	index = -1
	if not MapManager.world_maps:
		create_new_maps = true
	point_position = Vector2(64, get_viewport_rect().size.y / 2)
	_add_point(point_position, -1, 1, true)
	for index in range(length):
		point_position = Vector2(point_position.x + x_gap, get_viewport_rect().size.y / 2)
		var points_in_column = 3
		point_position.y -= y_gap
		if index % 2 == 0:
			points_in_column = 2
			point_position.y += y_gap/2
		for point in range(points_in_column):
			_add_point(point_position, index, point, false)
	point_position = Vector2(point_position.x + x_gap, get_viewport_rect().size.y / 2)
	_add_point(point_position, length, 1, false)

func _add_point(position_for_point : Vector2, column : int, id : int, active : bool):
	index+=1
	point_position.y += y_gap
	var m = map_node.instantiate()
	add_child(m)
	m.position = position_for_point
	m.column = column
	m.id = id
	m.active = active
	positions_to_draw.append(m.position)
	if create_new_maps:
		_generate_map()
		m.map = map_steps
		MapManager.world_maps.append(m.map)
	else:
		m.map = MapManager.world_maps[index]


func _generate_map():
	map_steps = []
	map_steps.append(map_position)
	var last_dir = Vector2.ZERO
	var steps_in_dir = 0
	var step = 1
	while step < steps:
		randomize()
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
