extends Area2D
@export var speed : float = 300
@onready var polygon_2d = $Polygon2D
@onready var collision_polygon_2d = $CollisionPolygon2D
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed('W_UP'):
		velocity.y -= speed
	if Input.is_action_pressed('S_DOWN'):
		velocity.y += speed
	var test = Vector2(0, collision_polygon_2d.get_global_transform()[2].y/2)
	position += velocity * delta
	position = position.clamp(Vector2.ZERO + test, screen_size - test)
