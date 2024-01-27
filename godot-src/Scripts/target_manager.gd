extends Node2D

class_name TargetManager

@export var target_duration : float

@onready var targets = {}

func remove_target(target: Node2D) -> void:
	targets.erase(target)

func add_target(target : Node2D) -> void :
	targets[target] = target_duration

func current_targets() -> Array:
	var target_list := []
	for target in targets.keys():
		if targets[target] > 0:
			target_list.append(target)
	return target_list

func _process(delta):
	for target in targets.keys():
		targets[target] = max(targets[target] - delta, 0)
	for target in targets.keys():
		target.is_angry = targets[target] > 0
