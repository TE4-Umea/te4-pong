extends Node

var id
var map = []
var step_size

var nums = [0, 1, 2, 3, 4, 5, 6]

func _ready():
	map = MapManager.current_map
	id = MapManager.current_world
	for location in map:
		var x = (get_viewport().get_visible_rect().size.x/2)/$TileMap.cell_quadrant_size
		var y = (get_viewport().get_visible_rect().size.y/2)/$TileMap.cell_quadrant_size
		var tile_x
		var tile_y
		if map.find(location) == 0:
			tile_x = 3
			tile_y = 0
		elif map.find(location) == map.size()-1:
			tile_x = 2
			tile_y = 1
		else:
			tile_x = 4
			tile_y = 3
		$TileMap.set_cell(0, Vector2i(x - location.x, y - location.y), 0, Vector2i(tile_x, tile_y))


func _on_walker_done_with_map(map_arr):
	map = map_arr
	self.step_size = step_size
	print(map.size())
	for location in map:
		var x = (get_viewport().get_visible_rect().size.x/2)/$TileMap.cell_quadrant_size
		var y = (get_viewport().get_visible_rect().size.y/2)/$TileMap.cell_quadrant_size
		var tile_x
		var tile_y
		if map.find(location) == 0:
			tile_x = 3
			tile_y = 0
		elif map.find(location) == map.size()-1:
			tile_x = 2
			tile_y = 1
		else:
			tile_x = 4
			tile_y = 3
		$TileMap.set_cell(0, Vector2i(x - location.x, y - location.y), 0, Vector2i(tile_x, tile_y))
	

func _process(delta):
	if Input.is_action_just_pressed("click"):
		get_tree().change_scene_to_file("res://Scenes/Map/OverWorld/OverworldMap.tscn")
