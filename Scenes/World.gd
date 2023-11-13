extends Node
var screensize

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport().get_visible_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/Label.text = str("x" + str(Main.p1_score))
	$Control/Label2.text = str("x" + str(Main.p2_score))



func _on_norr_body_entered(body):
	if !body.is_in_group('paddles'):
		body.direction.y *= -1


func _on_bottom_body_entered(body):
	if !body.is_in_group('paddles'):
		body.direction.y *= -1


func _on_kanye_body_entered(body):
	body.queue_free()
	var ball = preload("res://Scenes/Ball.tscn").instantiate()
	ball.global_position = Vector2(screensize.x / 2, screensize.y / 2)
	add_child(ball)
	Main.p2_score += 1

func _on_left_body_entered(body):#!left
	body.queue_free()
	var ball = preload("res://Scenes/Ball.tscn").instantiate()
	ball.global_position = Vector2(screensize.x / 2, screensize.y / 2)
	add_child(ball)
	Main.p1_score += 1
	
