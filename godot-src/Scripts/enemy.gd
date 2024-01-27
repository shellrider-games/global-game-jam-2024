class_name Enemy

extends StaticBody2D

@export var after_conversion_scene : Resource

func take_damage():
    var converted = after_conversion_scene.instantiate()
    converted.position = position
    add_sibling(converted)
    queue_free()