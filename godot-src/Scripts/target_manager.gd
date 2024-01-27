extends Node2D

class_name TargetManager

@onready var list = []

func add_target(target : Node2D) -> void :
    if target not in list:
        list.append(target)
    print(list)