extends CharacterBody2D

const SPEED = 200.0
const JUMP_FORCE = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var knockback_vector := Vector2.ZERO
var direction
var is_hurted := false

@onready var texture := $boneco as AnimatedSprite2D
@onready var remote_transform := $Remote as RemoteTransform2D
@onready var jump_sfx = $jump_sfx as AudioStreamPlayer

signal player_has_died()

func die():
	emit_signal("player_has_died")
	queue_free()
	get_tree().reload_current_scene()
   
	

func _ready():
	if not remote_transform:
		print("RemoteTransform2D node not found")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
		jump_sfx.play()

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
		texture.scale.x = direction
		if not is_jumping:
			texture.play("corrida")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_jumping:
			texture.play("idle")
	
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
		
		_set_state()

	if not is_on_floor():
		is_jumping = true
		texture.play("pulo")
	else:
		is_jumping = false
		

	move_and_slide()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if $ray_right.is_colliding():
			take_damage(Vector2(-200, -200))
	elif $ray_left.is_colliding():
			take_damage(Vector2(200, -200))

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	if Globals.player_life > 0:
		Globals.player_life -= 1
	else:
		queue_free()
		emit_signal("player_has_died")
		
	#if body.is.is_in_group("fireball"):
		#body.queue_free()


	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		
		# Change to red instantly
		texture.modulate = Color(1, 0, 0, 1)
		
		# Tween back to the original color
		knockback_tween.tween_property(texture, "modulate", Color(1, 1, 1, 1), duration)
		
	is_hurted = true
	
func _set_state():
	var state = "idle"
	
	if is_hurted:
		state = "hurt"
		
	if !is_on_floor():
			state ="pulo"
	elif direction != 0:
			state = "corrida"
			
	if  texture.name != state:
		texture.play(state)
	
		
	
	



