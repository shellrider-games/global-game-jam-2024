class_name Enemy

extends StaticBody2D

@export var after_conversion_scene : Resource
@export var player : Player
@export var tag_indicator : Node2D

var target_manager : TargetManager

func _ready():
    target_manager = get_tree().root.find_child(
        "TargetManager",
        true,
        false
    )
    


func take_damage():
    tag_indicator.visible = true
    target_manager.add_target(self)
