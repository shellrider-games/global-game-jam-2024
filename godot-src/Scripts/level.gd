extends Node2D

@export var player : Player
@export var hearts_display : HeartsDisplay

func _ready():
	hearts_display.monitor(player)
	
