extends CharacterBody2D

class_name Player

@export var speed : float = 30000
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

func _physics_process(delta):
	velocity = _movement_dir()*speed*delta
	move_and_slide()
	
