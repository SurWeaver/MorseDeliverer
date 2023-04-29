extends DelivererState


func _update(delta: float) -> void:
	if not Input.is_action_pressed("slide"):
		emit_signal("queried_transition_to", "Run")
