extends Control

@export var start_button : TextureButton

func _on_start_game_clicked():
	get_tree().change_scene_to_file("res://Scenes/level_0.tscn")

func _ready():
	start_button.pressed.connect(_on_start_game_clicked)

