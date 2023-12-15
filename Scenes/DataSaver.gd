extends Node

var master_volym : float = 1
var music_volym : float = 1
var sfx_volym : float = 1

var save_dir_path = "user://"
var save_file_path = save_dir_path + "save_data.dat"

func _ready():
	load_from_file()

func save_to_file():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)  
	var data = send_player_data()
	print(data)
	file.store_var(data)

func send_player_data():
	var player_options_sound = {
		"MASTER" : master_volym,
		"MUSIC_VOLYM" : music_volym,
		"SFX_VOLYM" : sfx_volym
	}
	return player_options_sound
	
func load_from_file():
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	if file == null:
		file = FileAccess.open(save_file_path, FileAccess.WRITE)
		var data = send_player_data()
		print(data)
		file.store_var(data)
	elif file.file_exists(save_file_path):
		var load_data = file.get_var()
		master_volym = load_data.MASTER
		music_volym = load_data.MUSIC_VOLYM
		sfx_volym = load_data.SFX_VOLYM
