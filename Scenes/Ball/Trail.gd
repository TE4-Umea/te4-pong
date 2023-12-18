extends Line2D

@export var max_length : int

var queue : Array

func _process(delta):
	var pos = $"..".position - position
	queue.push_front(pos)
	
	if queue.size() > max_length:
		queue.pop_back()
	
	clear_points()
	
	for point in queue:
		add_point(point)
