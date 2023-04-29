extends DelivererState


func _update(delta: float) -> void:
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("slide"):
		emit_signal("queried_transition_to", "Run")
