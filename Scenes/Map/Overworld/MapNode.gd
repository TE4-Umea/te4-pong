extends Area2D

@export var active = false
@export var connected : Array[Area2D] = []
@export var id = 0
@export var enemies : Array[PackedScene] = []
@export var boss : PackedScene

var path_scene = preload("res://Scenes/Map/Overworld/pathway.tscn")
var sibling
var chosen = false
var mouse_over = false
var paths = []

func _ready():
	if MapManager.node_state.size()-1 < id:
		MapManager.node_state.insert(id, active)
		MapManager.chosen_state.insert(id, chosen)
	else:
		active = MapManager.node_state[id]
		chosen = MapManager.chosen_state[id]

func _draw():
	if chosen:
		$AnimatedSprite2D.modulate = Color.GREEN
		$AnimatedSprite2D.play("idle")
	elif active:
		$AnimatedSprite2D.modulate = Color.WHITE
	else:
		$AnimatedSprite2D.modulate = Color.DIM_GRAY
	for node in connected:
		var path = path_scene.instantiate()
		add_child(path)
		paths.append(path)
		if node.chosen and active or chosen:
			#draw_line(position-position, node.position-position, Color.GREEN, 2)
			path.default_color = Color.GREEN
			path.add_point(position-position)
			path.add_point(node.position-position)
		else:
			#draw_line(position-position, node.position-position, Color.WEB_GRAY, 1)
			path.default_color = Color.GRAY
			path.add_point(position-position)
			path.add_point(node.position-position)

func _process(delta):
	if mouse_over and Input.is_action_just_pressed("click") and active and not chosen:
		$AnimatedSprite2D.play("open")
		await get_tree().create_timer(1).timeout
		chosen = true
		active = false
		global.is_boss = false
		global.enemy_list = enemies
		global.boss = boss
		MapManager.node_state[id] = active
		MapManager.chosen_state[id] = chosen
		MapManager.world_intensity += 1
		for node in connected:
			for route in connected:
				if node != route:
					node.sibling = route
			node.active = true
			MapManager.node_state[node.id] = true
		for node in get_tree().get_nodes_in_group("map_node"):
			node.queue_redraw()
		if sibling:
			sibling.active = false
			MapManager.node_state[sibling.id] = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		MapManager.current_world = id
		get_tree().change_scene_to_file("res://Scenes/Map/World/WorldMap.tscn")

func _on_mouse_entered():
	mouse_over = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited():
	mouse_over = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
