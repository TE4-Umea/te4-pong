extends Marker2D
@export var length : int = 3
@export var x_gap : int = 128
@export var y_gap : int = 192

@onready var map_node : PackedScene = preload("res://Scenes/Map/OverWorld/Map_Node.tscn")

var point_position
var positions_to_draw : Array[Vector2] = []

func _ready():
	point_position = Vector2(64, get_viewport_rect().size.y / 2)
	_add_point(point_position, -1, 1)
	for index in range(length):
		point_position = Vector2(point_position.x + x_gap, get_viewport_rect().size.y / 2)
		var points_in_column = 3
		point_position.y -= y_gap
		if index % 2 == 0:
			points_in_column = 2
			point_position.y += y_gap/2
		for point in range(points_in_column):
			_add_point(point_position, index, point)
	point_position = Vector2(point_position.x + x_gap, get_viewport_rect().size.y / 2)
	_add_point(point_position, length, 1)

func _add_point(position_for_point : Vector2, column : int, id : int):
	point_position.y += y_gap
	var m = map_node.instantiate()
	add_child(m)
	m.position = position_for_point
	m.column = column
	m.id = id
	positions_to_draw.append(m.position)

func _process(delta):
	pass
