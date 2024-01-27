extends Node2D

class_name Bullet

@export var speed : float
@export var max_distance_to_player : float
@export var collision_area : Area2D

var direction : Vector2
var player : Player

func _on_body_hit(body):
	if body.has_method("bullet_hit"):
		body.bullet_hit()
		queue_free()
	

func _ready():
	player  = get_tree().root.find_child(
		"Player",
		true,
		false
	)
	collision_area.body_entered.connect(_on_body_hit)

func _process(delta):
	position += speed * delta * direction.normalized()
	if (player.position - position).length() > max_distance_to_player:
		queue_free()
