extends DelivererState


func _update(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		emit_signal("queried_transition_to", "Run")
