extends Marker2D

var tween = create_tween()
var amount = 0

func _ready():
	get_node("Label").set_text(str(-amount))
	
	
	#tween.tween_property(get_node("Label"), "position", Vector2(2, 2), 1)
	
