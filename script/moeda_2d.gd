extends Area2D

@onready var coinss = $coins as AudioStreamPlayer


var coins := 1

func _ready():
	pass 

func _process(_delta):
	pass

func _on_body_entered(_body):
	print("O player colidiu com a moeda")
	$AnimatedSprite2D.play("collect") 
	coinss.play()
	await $colisao.call_deferred("queue_free")
	Globals.coins += coins
	print(Globals.coins)

func _on_animated_sprite_2d_animation_finished():
	queue_free()

