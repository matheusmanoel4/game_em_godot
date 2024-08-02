extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var direction = -1

@onready var detector = $wall_detector as RayCast2D
@onready var anime = $anime as Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	# Verificar se os nós foram encontrados corretamente
	if detector == null:
		print("Erro: Nó 'wall_detector' não encontrado")
	if anime == null:
		print("Erro: Nó 'anime' não encontrado")

	# Conectar o sinal 'body_entered' se detector for um Area2D
	if detector is Area2D:
		detector.connect("body_entered", self, "_on_body_entered")

func _physics_process(_delta):
	# Adiciona a gravidade
	if not is_on_floor():
		velocity.y += gravity * _delta

	if detector.is_colliding():
		direction *= -1
		detector.scale.x *= -1

	# Inverte a textura com base na direção
	if direction == 1:
		anime.flip_h = true
	else:
		anime.flip_h = false

	velocity.x = direction * SPEED
	move_and_slide()

func _on_anim_animation_finished(anim_name):
	if anim_name == "hurt":
		queue_free()

func _on_body_entered(body):
	direction *= -1
	detector.scale.x *= -1
	


	
