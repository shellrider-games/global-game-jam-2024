extends Control

class_name HeartsDisplay

@export var container : HBoxContainer
@export var heart_texture : Texture2D

func _empty_container() -> void:
	for node in container.get_children():
		container.remove_child(node)
		node.queue_free()

func update_max_hearts(amount : int) -> void:
	_empty_container()
	container.size = Vector2(96*amount,96)
	for i in range(amount):
		var noob = TextureRect.new()
		noob.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		noob.texture = heart_texture
		noob.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		container.add_child(noob)

func set_hearts(amount : int) -> void:
	for i in range(amount, container.get_child_count()):
		container.get_children()[i].modulate = Color(1,1,1,0.2)

func monitor(player : Player):
	update_max_hearts(player.max_health)
	player.max_health_changed.connect(update_max_hearts)
	player.health_changed.connect(set_hearts)