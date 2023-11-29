extends Control
var labol_color = "blue"
var pros_color = "green"
var cons_color = "red"
signal yes_button_pressed
signal no_button_pressed
var random_item
var item_stats : Array = []
var item : Array
var item_index : Array


func _ready():
	item_stats = []
	var json = $JsonData
	var json_size = json.json_file_size()
	random_item = (randi_range(0, json_size))
	add_to_item_stats(json, random_item)
	item.append_array([item_stats])
	item.append_array([item_stats])
	item.append_array([item_stats])
	item_index = [1,2,3]
	give_data_to_switch()
	
func set_label_name(name):
	var label_name = $Item/BackPanel/ItemName
	label_name.clear()
	#Namn kan inte vara över 34 tecken, anars försviner texten 
	label_name.append_text("[font_size={20}][color=" + 
	labol_color + "][center][b]" +
	name + "[/b][/center][/color][/font_size]")

func set_decsription(text):
	text = "[font_size={15}] " + text + " [/font_size]"
	var decript = $Item/BackPanel/Decription
	decript.clear()
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

func add_to_item_stats(json, random_item):
	item_stats.append(json.get_json_name(random_item))
	item_stats.append(json.get_json_desc(random_item))
	item_stats.append(json.get_json_ability(random_item))
	item_stats.append(json.get_json_rarity(random_item))	
	item_stats.append(json.get_json_element(random_item))
	item_stats.append(json.get_json_damage(random_item))
	item_stats.append(json.get_json_hp(random_item))
	item_stats.append(json.get_json_luck(random_item))
	item_stats.append(json.get_json_movment_speed(random_item))
	item_stats.append(json.get_json_ball_speed(random_item))

func give_data_to_switch():
	var switch = $UI_SwichItem
	switch.on_item_start(item, item_index)

func _on_ui_swich_item_button_1():
	set_label_name($UI_SwichItem.send_name)
	set_decsription($UI_SwichItem.send_desc)

func _on_ui_swich_item_button_2():
	set_label_name($UI_SwichItem.send_name)
	set_decsription($UI_SwichItem.send_desc)

func _on_ui_swich_item_button_3():
	set_label_name($UI_SwichItem.send_name)
	set_decsription($UI_SwichItem.send_desc)
