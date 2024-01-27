extends CharacterBody2D

class_name Minion

@export var speed : float
@export var max_distance_to_leader : float
@export var min_distance_to_leader : float
@export var epsilon : float
@export var sprite : Sprite2D

var leader : Player

func _process(delta):
    if leader and sprite:
        sprite.flip_h = (leader.position - position).x < 0

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
