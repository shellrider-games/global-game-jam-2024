extends Node2D

class_name Attack

@export var collision_area : Area2D

var already_attacked := []

func _on_body_entered(body : Node2D):
    if body not in already_attacked:
        already_attacked.append(body)
    if body.has_method("target"):
        body.target()
    if body.has_method("knockback_from"):
        body.knockback_from(position)

func _on_timeout() -> void:
    queue_free()

func _ready():
    var timer := get_tree().create_timer(0.5)
    timer.timeout.connect(_on_timeout)
    collision_area.body_entered.connect(_on_body_entered)
