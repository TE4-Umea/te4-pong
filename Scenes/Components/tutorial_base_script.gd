extends Control

signal go_left
signal go_right

func _on_left_button_pressed():
	go_left.emit()

func _on_right_button_pressed():
	go_right.emit()
