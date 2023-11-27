extends Node

var map = []
var step_size

var nums = [0, 1, 2, 3, 4, 5, 6]

func _on_walker_done_with_map(map_arr):
	map = map_arr
	self.step_size = step_size
	for location in map:
		var x = (get_viewport().get_visible_rect().size.x/2)/$TileMap.cell_quadrant_size
		var y = (get_viewport().get_visible_rect().size.y/2)/$TileMap.cell_quadrant_size
		$TileMap.set_cell(0, Vector2i(x - location.x, y - location.y), 0, Vector2i(nums.pick_random(), nums.pick_random()))
