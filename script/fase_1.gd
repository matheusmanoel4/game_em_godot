extends Node2D

@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D
@onready var control = $hud/Control
@onready var clock_timer = $hud/Control/container/clock_timer as Timer


@export var enemy_score := 100


func _ready() -> void:
	player.follow_camera(camera)
	player.player_has_died.connect(reload_game)
	


func _process(delta):
	pass

func reload_game() -> void:
	control.time_is_up.connect(reload_game)
	Globals.coins = 0  
	Globals.player_life = 3
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()


func _on_void_body_entered(body):
	if body.is_in_group("player"):
		$CharacterBody2D/AnimationPlayer.play("new_animation")
		await $CharacterBody2D/AnimationPlayer.animation_finished
		get_tree().reload_current_scene()
	pass # Replace with function body.
