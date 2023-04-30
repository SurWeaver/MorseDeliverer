class_name TalkParticle
extends CPUParticles2D


func set_symbol(symbol: String) -> void:
	match symbol:
		".":
			texture = preload("res://assets/sprites/dot.png")
		"-":
			texture = preload("res://assets/sprites/dash.png")
		"x":
			texture = preload("res://assets/sprites/wrong.png")
