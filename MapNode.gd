extends Marker2D

var column
var id

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	var nodes = get_tree().get_nodes_in_group("map_node")
	for node in nodes:
		print(node.column)
		if node.column == (column + 1):
			draw_line(Vector2.ZERO, node.position - position, Color.BLACK)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass