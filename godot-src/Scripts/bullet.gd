extends Node2D

class_name Bullet

@export var speed : float
@export var max_distance_to_player : float

var direction : Vector2
var player : Player

func _ready():
	player  = get_tree().root.find_child(
		"Player",
		true,
		false
	)

func _process(delta):
	position += speed * delta * direction.normalized()
	if (player.position - position).length() > max_distance_to_player:
		queue_free()
