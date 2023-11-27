extends Control

var mouse_focus = false
signal button_pressed

func _on_button_focus_entered():
	mouse_focus = true
	button_pressed.emit()


func _on_button_focus_exited():
	mouse_focus = false
