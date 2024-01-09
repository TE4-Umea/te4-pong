extends "res://Scenes/Enemeys/Enemy.gd"

func _ready():
	get_element_hit_sound()
	for n in range(global.player_items_index.size()):
		if(global.player_items_index[n] == 1):
			fire_damage *= 2
	get_tree().get_first_node_in_group("enemy_health").clear()
	get_tree().get_first_node_in_group("enemy_health").append_text("[center]" + str(ceil(hp)) + " HP[/center]")
	size = $CollisionShape2D.shape.size
	speed = 600
	resistance = 0
