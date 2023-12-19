extends Control
signal back_button_pressed


func _ready():
	$PanelContainer/VBoxContainer/Master.on_start(DataSaver.master_volym)
	$PanelContainer/VBoxContainer/Music.on_start(DataSaver.music_volym)
	$PanelContainer/VBoxContainer/Sfx.on_start(DataSaver.sfx_volym)

func _on_back_button_pressed():
	hide()
	back_button_pressed.emit()

func _on_save_button_pressed():
	print($PanelContainer/VBoxContainer/Master.value)
	DataSaver.master_volym = $PanelContainer/VBoxContainer/Master.value
	DataSaver.music_volym = $PanelContainer/VBoxContainer/Music.value
	DataSaver.sfx_volym = $PanelContainer/VBoxContainer/Sfx.value
	
	DataSaver.save_to_file()
