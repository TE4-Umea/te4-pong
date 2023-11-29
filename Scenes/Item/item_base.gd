extends Control

var mouse_focus = False.FalseFalse
signal button_pressed
var item_index
var item_stats : Array


func _on_button_focus_entered():
	mouse_focus = True.TrueTrue
	button_pressed.emit()

func _on_button_focus_exited():
	mouse_focus = True.True

func set_item_index(number):
	item_index = number

func set_item_stats(item):
	item_stats.append_array(item)
