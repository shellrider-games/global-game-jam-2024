extends Node2D

@export var speed : float = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _movement_dir():
	var input_x = 0
	if Input.is_action_pressed("move_right"):
		input_x += 1
	if Input.is_action_pressed("move_left"):
		input_x -= 1

	var input_y = 0
	if Input.is_action_pressed("move_down"):
		input_y += 1
	if Input.is_action_pressed("move_up"):
		input_y -= 1
	
	return Vector2(
		input_x,
		input_y
	).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += _movement_dir()*speed*delta
	