extends Area2D

func _ready():


func _on_body_entered(body):
	if body.name == "player" and body.has_method("die"):
		body.die()

