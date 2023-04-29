extends DelivererState


func _enter(message: Dictionary = {}) -> void:
	._enter()
	if message.has("emit_splash") and message["emit_splash"]:
		deliverer.emit_back_step_splash()
		deliverer.emit_front_step_splash()

func _update(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		emit_signal("queried_transition_to", "Jump")
	elif Input.is_action_pressed("slide"):
		emit_signal("queried_transition_to", "Slide")
