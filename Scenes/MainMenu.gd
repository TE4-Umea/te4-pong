extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Map/World.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Map/Overworld/Overworld.tscn")

func _process(delta):
	$ParallaxBackground.scroll_offset.x += 20*delta
