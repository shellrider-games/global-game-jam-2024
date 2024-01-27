extends CharacterBody2D

class_name Minion

@export var speed : float
@export var max_distance_to_leader : float
@export var min_distance_to_leader : float
@export var epsilon : float
@export var sprite : Sprite2D
@export var leader : Player
@export var bullet_scene : Resource
@export var bullet_spawn : Node2D

@export var time_between_shots : float = 0.33

@onready var shoot_cooldown = time_between_shots
var target_manager : TargetManager

func bullet_hit():
	pass

func _spawn_bullet(target):
	var bullets = get_tree().root.find_child(
		"Bullets",
		true,
		false
	)
	var noob = bullet_scene.instantiate()
	noob.global_position = bullet_spawn.global_position
	noob.direction = (target.global_position - bullet_spawn.global_position) \
		.normalized()
	bullets.add_child(noob)

func _nearest_target():
	var nearest_target = null
	for target in target_manager.current_targets():
		if not nearest_target:
			nearest_target = target
			continue
		if (target.position - position).length() \
			< (nearest_target.position - position):
			nearest_target = target
	return nearest_target

func _ready():
	target_manager = get_tree().root.find_child(
		"TargetManager",
		true,
		false
	)

func _process(delta):
	if leader and sprite:
		if (leader.position - position).x < 0:
			transform.x.x = -1
		else:
			transform.x.x = 1
	var nearest_target = _nearest_target()
	if nearest_target:
		shoot_cooldown -= delta
		if shoot_cooldown <= 0:
			shoot_cooldown += time_between_shots
			_spawn_bullet(nearest_target)

func _desired_position() -> Vector2:
	var desired_position = position
	if leader:
		if (leader.position - position).length() > max_distance_to_leader:
			desired_position = leader.position + \
			(position - leader.position).normalized() * max_distance_to_leader
		elif (leader.position - position).length() < min_distance_to_leader:
			desired_position = leader.position + \
			(position - leader.position).normalized() * min_distance_to_leader
	return desired_position

func _physics_process(delta):
	if (_desired_position()-position).length() > epsilon:
		velocity = (_desired_position() - position).normalized() \
		* speed * delta
	else:
		velocity = Vector2(0,0)
	move_and_slide()
