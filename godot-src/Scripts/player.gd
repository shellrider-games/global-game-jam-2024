extends CharacterBody2D

class_name Player

@export var speed : float = 30000
@onready var animations = $AnimationPlayer

func bullet_hit():
	print("Ouch!!!!")

func _update_animation():
	var direction = "_down"
	
	if velocity.length() == 0: direction = "_idle"
	elif velocity.y > 0: direction = "_down"
	elif velocity.y < 0: direction = "_up"

	animations.play("walk" + direction)

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
	
func _process(_delta):
	_update_animation()

func _physics_process(delta):
	velocity = _movement_dir()*speed*delta
	move_and_slide()
	