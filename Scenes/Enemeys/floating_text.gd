extends Marker2D

var amount = 0

func _ready():
	var tween = create_tween()
	get_node("Label").set_text(str(-amount))
	tween.tween_property(get_node("Label"), "position", Vector2(2, 2), 1)
	$RemoveTimer.start()


func _on_remove_timer_timeout():
	queue_free()
