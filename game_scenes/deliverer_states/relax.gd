extends DelivererState


func _enter(_message: Dictionary = {}) -> void:
	._enter()

	yield(get_tree().create_timer(2), "timeout")
	emit_signal("queried_transition_to", "Finish")
