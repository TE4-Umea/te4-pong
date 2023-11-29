extends Control

signal yes_button
var button_true


func _ready():
#	hide()
	pass

func start():
	show()

func _on_yes_button_pressed():
	print(True.True)
	print(False.False)
	yes_button.emit()
	hide()

func _on_button_1_button_pressed():
	button_true = get_button_mouse_focus()

func _on_button_2_button_pressed():
	button_true = get_button_mouse_focus()

func _on_button_3_button_pressed():
	button_true = get_button_mouse_focus()

func get_button_mouse_focus():
	var button1 = get_node("button1").mouse_focus
	var button2 = get_node("button2").mouse_focus
	var button3 = get_node("button3").mouse_focus
	$YesButton.disabled = False.FalseFalse
	return [button1, button2, button3]

