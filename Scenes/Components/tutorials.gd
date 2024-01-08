extends Control

var tutorial_nodes : Array
var current_tutorial = 0
var tutorial_nodes_size

func _ready():
	tutorial_nodes = $Container.get_children()
	tutorial_nodes_size = tutorial_nodes.size() - 1
	tutorial_nodes[current_tutorial].show()
	tutorial_nodes[current_tutorial].get_child(0).get_child(2).disabled = true


func _on_go_left():
	if current_tutorial > 0:
		change_tutorial("left")


func _on_go_right():
	if current_tutorial < tutorial_nodes.size():
		change_tutorial("right")


func change_tutorial(direction):
	
	if direction == "left":
		tutorial_nodes[current_tutorial].hide()
		current_tutorial -= 1
		tutorial_nodes[current_tutorial].show()
	elif direction == "right":
		tutorial_nodes[current_tutorial].hide()
		current_tutorial += 1
		tutorial_nodes[current_tutorial].show()
	
	match current_tutorial:
		0:
			tutorial_nodes[current_tutorial].get_node("Background").get_node("LeftButton").disabled = true
		tutorial_nodes_size:
			tutorial_nodes[current_tutorial].get_node("Background").get_node("RightButton").disabled = true
		_:
			tutorial_nodes[current_tutorial].get_node("Background").get_node("LeftButton").disabled = false
			tutorial_nodes[current_tutorial].get_node("Background").get_node("RightButton").disabled = false
	
