extends Marker2D

var column
var id
var mouse_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	draw_circle(Vector2.ZERO, 3, Color.BLACK)
	var nodes = get_tree().get_nodes_in_group("map_node")
	if column % 2 == 0:
		for node in nodes:
			if node.column == (column + 1):
				if node.id == id or id + 1 == node.id: 
					draw_line(Vector2.ZERO, node.position - position, Color.BLACK)
	else:
		for node in nodes:
			if node.column == (column + 1):
				if node.id == id or id - 1 == node.id: 
					draw_line(Vector2.ZERO, node.position - position, Color.BLACK)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_over and Input.is_action_just_pressed("click"):
		get_tree().change_scene_to_file("res://Scenes/Map/World/WorldMap.tscn")


func _on_area_2d_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	$Sprite2D.modulate = Color.GRAY
	mouse_over = true


func _on_area_2d_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	$Sprite2D.modulate = Color.WHITE
	mouse_over = false
