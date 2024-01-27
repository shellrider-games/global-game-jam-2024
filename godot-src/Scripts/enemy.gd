class_name Enemy

extends StaticBody2D

@export var after_conversion_scene : Resource
@export var player : Player

var target_manager : TargetManager

func _ready():
    target_manager = get_tree().root.find_child("TargetManager")
    print(target_manager)


func take_damage():
    var converted = after_conversion_scene.instantiate()
    converted.set_deferred("position", position)
    converted.set_deferred("leader", player)
    call_deferred("add_sibling", converted)
    queue_free()
