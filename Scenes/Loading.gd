extends Control

var target_scene_path = "res://Scenes/Map/World.tscn"
var loading_status : int
var progress : Array[float]
var loaded = false
var tips_strings = ["Try to deflect the balls.", "Enemies get hurt when they take damage.", "You lose when your HP reaches zero.", "If an enemy seems hard to hit, try to aim a little better."]

@onready var loading_bar : ProgressBar = $LoadingBar
@onready var label : Label = $Label
@onready var tips : Label = $Tips

func _ready():
	ResourceLoader.load_threaded_request(target_scene_path)
	tips.text = tips_strings.pick_random()

func _process(delta):
	loading_status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			loading_bar.value = progress[0] * 100
		ResourceLoader.THREAD_LOAD_LOADED:
			loading_bar.visible = false
			label.visible = true
			loaded = true
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Load Error")

func _input(event):
	if loaded and event.is_pressed() and (InputEventKey or InputEventMouse):
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene_path))
