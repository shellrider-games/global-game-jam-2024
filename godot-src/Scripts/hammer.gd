extends Node2D

@export var follow_target : Node2D
@export var offset : Vector2
@export var sprite : Sprite2D

@export var attack_scene : Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _update_position():
	var mouse_pos = get_viewport().get_mouse_position()
	var hammer_dir = (follow_target.position - mouse_pos).normalized()
	position = follow_target.position +  Vector2(0,offset.y) + \
		hammer_dir * offset.x

func _is_right_of_target():
	return follow_target.position.x <= position.x

func _rotate_if_attacking():
	if Input.is_action_pressed("attack"):
		if _is_right_of_target():
			sprite.rotation_degrees = 30
		else:
			sprite.rotation_degrees = -30
	else:
		sprite.rotation_degrees = 0

func _spawn_attack_if_just_clicked():
	if Input.is_action_just_pressed("attack"):
		var instance = attack_scene.instantiate()
		instance.position = position
		add_sibling(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_update_position()
	sprite.flip_h = _is_right_of_target()
	_spawn_attack_if_just_clicked()
	_rotate_if_attacking()
