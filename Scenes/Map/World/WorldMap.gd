extends Node

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

@export var tile_scene : PackedScene
@export var enemy_risk = 25
@export var enemies = 8
@export var world_size = 15

var map_position = Vector2.ZERO
var map = []
var id
var step_size
var player = Vector2.ZERO
var unused_tiles = []
var enemy_tiles = []
var offset : int
var end
var key
var has_key = false

func _generate_map():
	enemies *= MapManager.world_intensity*2
	map = []
	map.append(map_position)
	var last_dir = Vector2.ZERO
	var steps_in_dir = 0
	var step = 1
	while step < world_size + (MapManager.world_intensity*7):
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

func _ready():
	_generate_map()
	MapManager.current_map = map
	id = MapManager.current_world
	var key_location = randi_range(1, map.size()-2)
	for location in map:
		var tile : Area2D = tile_scene.instantiate()
		add_child(tile)
		offset = tile.get_child(0).texture.get_width() * tile.get_child(0).scale.x
		tile.get_child(2).text = str(location)
		
		var x = (get_viewport().get_visible_rect().size.x/2)
		var y = (get_viewport().get_visible_rect().size.y/2)
		tile.position = Vector2(x+(location.x * offset), y+(location.y * offset))
		
		if map.find(location) == 0:
			player = location
			$Player.position = tile.position
			tile.modulate = Color.GREEN
		elif map.find(location) == map.size()-1:
			tile.modulate = Color.RED
			end = location
		elif map.find(location) == key_location:
			key = location
			tile.modulate = Color.YELLOW
		else:
			unused_tiles.append(location)
			tile.modulate = Color.DIM_GRAY

func _move(direction):
	if player + direction in map:
		player += direction
		$Player.position += Vector2(direction.x * offset, direction.y * offset)
		if player == key and not has_key:
			print("Picked up Key")
			has_key = true
		elif player == end:
			if has_key:
				get_tree().change_scene_to_file("res://Scenes/Map/Overworld/Overworld.tscn")
		else:
			var random = randi_range(0, 100)
			if random < enemy_risk and enemies > 0:
				enemies -= 1
				print("ENEMY")

func _process(delta):
	if Input.is_action_just_pressed("P1_UP"):
		_move(Vector2.UP)
	elif Input.is_action_just_pressed("P1_DOWN"):
		_move(Vector2.DOWN)
	elif Input.is_action_just_pressed("P1_LEFT"):
		_move(Vector2.LEFT)
	elif Input.is_action_just_pressed("P1_RIGHT"):
		_move(Vector2.RIGHT)
