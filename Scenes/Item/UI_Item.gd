extends Control
var labol_color = "blue"
var pros_color = "green"
var cons_color = "red"
signal yes_button_pressed
signal no_button_pressed
var random_item

func _ready():
	var json = $JsonData
	var json_size = json.json_file_size()
	random_item = (randi_range(0, json_size))
	set_label_name(json.get_json_name(random_item))
	set_decsription(json.get_json_desc(random_item))

func set_label_name(name):
	var label_name = $Item/BackPanel/ItemName
	#Namn kan inte vara över 34 tecken, anars försviner texten 
	label_name.append_text("[font_size={20}][color=" + 
	labol_color + "][center][b]" +
	name + "[/b][/center][/color][/font_size]")

func set_decsription(text):
	text = "[font_size={15}] " + text + " [/font_size]"
	var decript = $Item/BackPanel/Decription
	var text_lengt = len(text)
	var count_pros = text.count("¥", 0, text_lengt )
	var count_cons = text.count("€", 0, text_lengt )
	var word_index1 = 0
	var word_index2 = 0
	
	for n in range(count_pros):
		word_index1 = text.find("¥", word_index1) + 1
		word_index2 = text.find("€", word_index1)
		var test = text.substr(word_index1, word_index2 - word_index1)
		test = test.to_upper()
		text = text.replacen(test, test)
	
	word_index1 = 0
	word_index2 = 0
	
	for n in range(count_cons):
		word_index1 = text.find("¤", word_index1) + 1
		word_index2 = text.find("æ", word_index1)
		var test = text.substr(word_index1, word_index2 - word_index1)
		test = test.to_upper()
		text = text.replacen(test, test)
	
	text = text.replace("¥", "[color=" + pros_color + "]" )
	text = text.replace("€", "[/color]")
	text = text.replace("¤", "[color=" + cons_color + "]")
	text = text.replace("æ", "[/color]")
	
	decript.append_text(text)

func _on_yes_button_pressed():
	if(global.player_items.size() < 3):
		var item_storage = []
		item_storage.append(random_item)
		global.update_player_items(item_storage)
		yes_button_pressed.emit()
	else: 
		$Item.hide()
		$UI_SwichItem.start()

func _on_no_button_pressed():
	print(global.player_items)
	no_button_pressed.emit()


func _on_ui_swich_item_remove_button():
	$UI_SwichItem.hide()
	$Item.show()
	print(global.player_items)
	var item_storage = []
	item_storage.append(random_item)
	print(global.player_items)
	global.update_player_items(item_storage)
	print(global.player_items)
	yes_button_pressed.emit()
	
