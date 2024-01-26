extends Node2D

@export var follow_target : Node2D
@export var offset : Vector2
@export var sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _update_position():
	var mouse_pos = get_viewport().get_mouse_position()
	var hammer_dir = (follow_target.position - mouse_pos).normalized()
	position = follow_target.position +  Vector2(0,offset.y) + \
		hammer_dir * offset.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_position()
	sprite.flip_h = follow_target.position.x <= position.x
