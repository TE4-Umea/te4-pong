extends Node

@export var tile_scene : PackedScene
@export var encounters = 7

var id
var map = []
var step_size
var player = Vector2.ZERO
var unused_tiles = []
var enemy_tiles = []
var offset : int
var end

func _ready():
	map = MapManager.current_map
	id = MapManager.current_world
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
		else:
			unused_tiles.append(tile)
			tile.modulate = Color.DIM_GRAY
	var random_tile = unused_tiles.pick_random()
	unused_tiles.erase(random_tile)
	random_tile.modulate = Color.YELLOW
	for encounter in encounters:
		random_tile = unused_tiles.pick_random()
		unused_tiles.erase(random_tile)
		random_tile.modulate = Color.ORANGE
		enemy_tiles.append(random_tile)

func _move(direction):
	if player + direction in map:
		player += direction
		$Player.position += Vector2(direction.x * offset, direction.y * offset)
		if player == end:
			get_tree().change_scene_to_file("res://Scenes/Map/Overworld/Overworld.tscn")

func _process(delta):
	if Input.is_action_just_pressed("P1_UP"):
		_move(Vector2.UP)
	elif Input.is_action_just_pressed("P1_DOWN"):
		_move(Vector2.DOWN)
	elif Input.is_action_just_pressed("P1_LEFT"):
		_move(Vector2.LEFT)
	elif Input.is_action_just_pressed("P1_RIGHT"):
		_move(Vector2.RIGHT)
