extends Node

var item_data = {}
var data_file_path = "res://Scenes/Items/destruktiv.json"

func _ready():
	item_data = load_json_file(data_file_path)

func load_json_file(filPath : String):
	if FileAccess.file_exists(filPath):
		var dataFile = FileAccess.open(filPath, FileAccess.READ)
		var parseResult = JSON.parse_string(dataFile.get_as_text())
		
		if parseResult is Dictionary:
			return parseResult
		else:
			print("Error reading file!")
	else:
		print("file no exist!")
