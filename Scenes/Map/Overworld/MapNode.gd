extends Area2D

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

@export var active = false
@export var world_size = 10
@export var connected : Array[Area2D] = []
@export var id = 0

var sibling
var chosen = false
var mouse_over = false
var map = []
var map_position = Vector2.ZERO

func _ready():
	if MapManager.world_maps.size()-1 < id :
		_generate_map()
		for node in range(get_tree().get_nodes_in_group("map_node").size()):
			MapManager.node_state.append(false)
	else:
		map = MapManager.world_maps[id]
		active = MapManager.node_state[id]
	MapManager.current_map = map

func _draw():
	if chosen:
		$Sprite2D.modulate = Color.GREEN
	elif active:
		$Sprite2D.modulate = Color.YELLOW
	else:
		$Sprite2D.modulate = Color.DIM_GRAY
	for node in connected:
		if node.active and active:
			draw_line(position-position, node.position-position, Color.GREEN, 2)
		else:
			draw_line(position-position, node.position-position, Color.WEB_GRAY, 1)

func _process(delta):
	if mouse_over and Input.is_action_just_pressed("click") and active and not chosen:
		chosen = true
		active = true
		MapManager.node_state.insert(id, active)
		for node in connected:
			for route in connected:
				if node != route:
					node.sibling = route
			node.active = true
		for node in get_tree().get_nodes_in_group("map_node"):
			node.queue_redraw()
		if sibling:
			sibling.active = false
		get_tree().change_scene_to_file("res://Scenes/Map/World/WorldMap.tscn")

func _generate_map():
	map = []
	map.append(map_position)
	var last_dir = Vector2.ZERO
	var steps_in_dir = 0
	var step = 1
	while step < world_size:
		randomize()
		var dir = DIRECTIONS.pick_random()
		if last_dir == dir:
			steps_in_dir += 1
			if steps_in_dir >= 2:
				steps_in_dir = 0
				dir *= -1
		map_position = map_position + dir
		if map_position not in map:
			map.append(map_position)
			step += 1
		last_dir = dir
	MapManager.world_maps.insert(id, map)

func _on_mouse_entered():
	mouse_over = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited():
	mouse_over = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
