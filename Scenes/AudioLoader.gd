extends Node

var enemy_battle_music = []
var enemy_element_hit_sound = []
var element_sound = []

func _ready():
	enemy_battle_music.append(load("res://Assets/Music/2022-04-13_-_Brace_For_Impact_-_www.FesliyanStudios.com.mp3"))
	
	#fire
	enemy_element_hit_sound.append(load("res://Assets/Sounds/enmey_hit.mp3"))
	#ice
	enemy_element_hit_sound.append(load("res://Assets/Sounds/ice_hit.wav"))
	#earth
	enemy_element_hit_sound.append(load("res://Assets/Sounds/rock_hit_enemy.mp3"))
	#water
	enemy_element_hit_sound.append(load("res://Assets/Sounds/water_hit.wav"))
	#light
	enemy_element_hit_sound.append(load("res://Assets/Sounds/light_hit.mp3"))
	#darkness
	enemy_element_hit_sound.append(load("res://Assets/Sounds/darkness_hit.mp3"))
	
	#spirit
	element_sound.append(load("res://Assets/Sounds/spirit.wav"))
	#air
	element_sound.append(load("res://Assets/Sounds/air_shoot.wav"))
	#lightning
	element_sound.append(load("res://Assets/Sounds/lighting.mp3"))
	
