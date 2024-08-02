extends Area2D

@onready var transitions = $"../transitions"
@export var next_level: String = ""

func _on_body_entered(body):
	if body.name == "player" and next_level != "":
		transitions.change_scene(next_level)
	else:
		print("meu ovo")
		

	
