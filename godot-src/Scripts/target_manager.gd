extends Node2D

class_name TargetManager

@export var target_duration : float

@onready var targets = {}


func add_target(target : Node2D) -> void :
	targets[target] = target_duration

func _process(delta):
	for target in targets.keys():
		targets[target] = max(targets[target] - delta, 0)
	for target in targets.keys():
		target.tag_indicator.visible = targets[target] > 0
