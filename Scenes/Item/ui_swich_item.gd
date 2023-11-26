extends Control

signal remove_button
signal no_button
var button_true


func _ready():
	hide()

func start():
	show()

func _on_remove_button_pressed():
	delet_item(button_true)
	remove_button.emit()

func _on_no_buton_pressed():
	no_button.emit()

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
	$RemoveButton.disabled = false
	return [button1, button2, button3]

func delet_item(button_true):
	while(global.player_items.size() > 3):
		global.player_items.pop_back()
	var index = button_true.find(true, 0)
	global.player_items.remove_at(index)
	print("print 3")
	print(global.player_items)

