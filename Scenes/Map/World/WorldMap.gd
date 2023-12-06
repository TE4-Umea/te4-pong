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
var key_index

func _generate_map():
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
	if MapManager.saved == true:
		map = MapManager.current_map
		id = MapManager.current_world
		key_index = MapManager.key_index
		end = MapManager.end_pos
		key = MapManager.key_pos
		has_key = MapManager.has_key
		enemies = MapManager.enemies
	else:
		_generate_map()
		MapManager.current_map = map
		id = MapManager.current_world
		key_index = randi_range(1, map.size()-2)
	
	for location in map:
		var tile : Area2D = tile_scene.instantiate()
		add_child(tile)
		offset = tile.get_child(0).texture.get_width() * tile.get_child(0).scale.x
		tile.get_child(2).text = str(location)
		
		var x = (get_viewport().get_visible_rect().size.x/2)
		var y = (get_viewport().get_visible_rect().size.y/2)
		tile.position = Vector2(x+(location.x * offset), y+(location.y * offset))
		
		if map.find(location) == 0:
			if not MapManager.saved:
				player = location
				$Player.position = tile.position
			else:
				player = MapManager.player_pos
				$Player.position = MapManager.player_global_pos + Vector2(x, y)
#			tile.modulate = Color.GREEN
		elif map.find(location) == map.size()-1:
			tile.modulate = Color.RED
			end = location
		elif map.find(location) == key_index:
			#key = location
			if not has_key:
				$Key.position = tile.position
			else:
				$Key.queue_free()
#			tile.modulate = Color.YELLOW
		else:
			unused_tiles.append(location)
#			tile.modulate = Color.DIM_GRAY

func _save():
	MapManager.saved = true
	MapManager.key_index = key_index
	MapManager.end_pos = end
	MapManager.key_pos = key
	MapManager.has_key = has_key
	MapManager.player_pos = player
	MapManager.player_global_pos = Vector2(player.x * offset, player.y * offset)
	MapManager.enemies = enemies

func _move(direction):
	if player + direction in map:
		player += direction
		$Player.position += Vector2(direction.x * offset, direction.y * offset)
		if player == key and not has_key:
			print("Picked up Key")
			has_key = true
			_save()
		elif player == end:
			if has_key:
				MapManager.saved = false
				get_tree().change_scene_to_file("res://Scenes/Map/World.tscn")
		else:
			var random = randi_range(0, 100)
			if random < enemy_risk and enemies > 0:
				enemies -= 1
				print("ENEMY")
				get_tree().change_scene_to_file("res://Scenes/Map/World.tscn")
			_save()

func _process(delta):
	if Input.is_action_just_pressed("P1_UP"):
		_move(Vector2.UP)
	elif Input.is_action_just_pressed("P1_DOWN"):
		_move(Vector2.DOWN)
	elif Input.is_action_just_pressed("P1_LEFT"):
		_move(Vector2.LEFT)
	elif Input.is_action_just_pressed("P1_RIGHT"):
		_move(Vector2.RIGHT)
#	elif Input.is_action_just_pressed("click"):
#		get_tree().change_scene_to_file("res://Scenes/Map/World/WorldMap.tscn")


func _on_key_body_entered(body):
	has_key = true
	_save()
	$Key.queue_free()
