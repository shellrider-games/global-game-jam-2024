extends Node2D

class_name Attack

func _on_timeout() -> void:
    queue_free()

func _ready():
    var timer := get_tree().create_timer(0.5)
    timer.timeout.connect(_on_timeout)
    print("Here")