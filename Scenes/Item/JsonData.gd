extends Node

var data_file_path = "res://Scenes/Item/destruktiv.json"

func load_json_file(filPath : String, id):
	if FileAccess.file_exists(filPath):
		var dataFile = FileAccess.open(filPath, FileAccess.READ)
		var parseResult = JSON.parse_string(dataFile.get_as_text())
		if parseResult is Array:
			return parseResult[id]
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
