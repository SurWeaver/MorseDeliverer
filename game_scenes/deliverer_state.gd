class_name DelivererState
extends State

onready var deliverer = owner as Deliverer


func _enter(_message: Dictionary = {}) -> void:
	deliverer.play_animation(name.to_lower())
