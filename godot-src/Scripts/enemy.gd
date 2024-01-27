class_name Enemy

extends CharacterBody2D

@export var after_conversion_scene : Resource
@export var player : Player
@export var tag_indicator : Node2D

@export var knockback_amount : float
@export var friction : float = 0.1
@export var move_epsilon : float = 1

var target_manager : TargetManager

func _ready():
	target_manager = get_tree().root.find_child(
		"TargetManager",
		true,
		false
	)
	
func knockback_from(pos : Vector2) -> void:
	var direction = (position - pos).normalized()
	velocity = direction * knockback_amount

func target():
	target_manager.add_target(self)

func _physics_process(delta):
	if velocity.length() > move_epsilon:
		velocity = lerp(velocity, Vector2(0,0), clamp(friction*delta,0,1))
	move_and_slide()
	
