extends Control

func _ready():
	$AudioOptions.hide()

func _on_button_play_pressed():
	$StartGame.play()
	$ButtonPlay.disabled = true
	$ButtonOptions.disabled = true
	global.main_song_timer = $Music.get_playback_position()
	$Music.stop()

func _on_button_options_pressed():
	$AudioOptions.show()
	$ButtonPlay.hide()
	$ButtonOptions.hide()

func _on_audio_options_back_button_pressed():
	$AudioOptions.hide()
	$ButtonPlay.show()
	$ButtonOptions.show()

func _on_start_game_finished():
	get_tree().change_scene_to_file("res://Scenes/Map/Overworld/Overworld.tscn")

func _process(delta):
	$ParallaxBackground.scroll_offset.x += 20*delta
