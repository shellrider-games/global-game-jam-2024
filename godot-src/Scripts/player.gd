extends CharacterBody2D

class_name Player

signal max_health_changed(amount)
signal health_changed(amount)

@export var speed : float = 30000
@onready var animations = $AnimationPlayer
@onready var max_health = 3
@onready var health = max_health
@onready var oof_audio : AudioStreamPlayer = get_tree().root.find_child(
	"OofAudio",
	true,
	false
)

func level_up():
	max_health += 1
	health += 1
	max_health_changed.emit(max_health)
	health_changed.emit(health)

func bullet_hit():
	oof_audio.play(0)
	health -= 1
	health_changed.emit(health)
	if(health <= 0):
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
	
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
	
