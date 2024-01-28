class_name Enemy

extends CharacterBody2D

@export var bullet_scene : Resource
@export var after_conversion_scene : Resource
@export var after_conversion_texture : Texture2D
@export var tag_indicator : Node2D
@export var bullet_spawn : Node2D

@export var knockback_amount : float
@export var friction : float = 0.1
@export var move_epsilon : float = 1
@export var time_between_shots = 0.33

var target_manager : TargetManager
var is_angry : bool
var shoot_cooldown : float
var player : Player
var health : int = 5
var bonk_audio : AudioStreamPlayer

func knockback_from(pos : Vector2) -> void:
    var direction = (position - pos).normalized()
    velocity = direction * knockback_amount

func _convert_to_minion():
    var noob = after_conversion_scene.instantiate()
    noob.set_deferred("position", position)
    noob.set_deferred("leader", player)
    noob.sprite.set_deferred("texture", after_conversion_texture)
    call_deferred("add_sibling", noob)
    player.level_up()
    target_manager.remove_target(self)
    queue_free()

func bullet_hit():
    health -= 1
    if health <= 0:
        _convert_to_minion()

func _ready():
    target_manager = get_tree().root.find_child(
        "TargetManager",
        true,
        false
    )
    player = get_tree().root.find_child(
        "Player",
        true,
        false
    )
    bonk_audio = get_tree().root.find_child(
        "BonkAudio",
        true,
        false
    )
    is_angry = false
    
func target():
    if bonk_audio and not bonk_audio.playing:
        bonk_audio.play(0)
    if not is_angry:
        shoot_cooldown = time_between_shots
    target_manager.add_target(self)

func _spawn_bullet():
    var bullets = get_tree().root.find_child(
        "Bullets",
        true,
        false
    )
    var noob = bullet_scene.instantiate()
    noob.global_position = bullet_spawn.global_position
    noob.direction = (player.global_position - bullet_spawn.global_position) \
        .normalized()
    bullets.add_child(noob)


func _process(delta):
    tag_indicator.visible = is_angry
    if is_angry:
        shoot_cooldown -= delta
        if(shoot_cooldown <= 0):
            shoot_cooldown += time_between_shots
            _spawn_bullet()

func _physics_process(delta):
    if velocity.length() > move_epsilon:
        velocity = lerp(velocity, Vector2(0,0), clamp(friction*delta,0,1))
    move_and_slide()
    
