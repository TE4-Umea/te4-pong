extends Node

var data_file_path = "res://Scenes/Item/item.json"

func json_file_size():
	if FileAccess.file_exists(data_file_path):
		var data_file = FileAccess.open(data_file_path, FileAccess.READ)
		var parse_result = JSON.parse_string(data_file.get_as_text())
		if parse_result is Array:
			return parse_result.size() - 1
		else:
			print("Error cant get size")
	else:
		print("file no exist!")

func load_json_file(fil_path : String, id):
	if FileAccess.file_exists(fil_path):
		var data_file = FileAccess.open(fil_path, FileAccess.READ)
		var parse_result = JSON.parse_string(data_file.get_as_text())
		if parse_result is Array:
			return parse_result[id]
		else:
			print("Error reading file!")
	else:
		print("file no exist!")

func get_json_spesific(object, id):
	var item_data = load_json_file(data_file_path, id)
	return item_data[object] 

func get_json_stats(object, id):
	var item_data = load_json_file(data_file_path, id)
	return item_data["stats"][object]

func get_json_name(id):
	return get_json_spesific("name", id)

func get_json_desc(id):
	return get_json_spesific("desc", id)

func get_json_ability(id):
	return get_json_spesific("ability", id)

func get_json_rarity(id):
	return get_json_spesific("rarity", id)

func get_json_element(id):
	return get_json_spesific("element", id)

func get_json_damage(id):
	return get_json_stats("damage", id)

func get_json_hp(id):
	return get_json_stats("hp", id)

func get_json_luck(id):
	return get_json_stats("luck", id)

func get_json_movment_speed(id):
	return get_json_stats("movment_speed", id)

func get_json_ball_speed(id):
	return get_json_stats("ball_speed", id)
