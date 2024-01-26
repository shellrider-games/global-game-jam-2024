extends Node2D

@export var follow_target : Node2D
@export var offset : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = follow_target.position + offset
	
