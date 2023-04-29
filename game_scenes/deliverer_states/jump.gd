extends DelivererState


const JUMP_HEIGHT: float = 60.0


export var jump_time_amount: float
export var jump_curve: Curve

var current_jump_time: float

onready var ground_height = deliverer.position.y


func _enter(_message: Dictionary = {}) -> void:
	._enter()
	current_jump_time = 0

func _update(delta: float) -> void:
	deliverer.position.y = ground_height - get_jump_height()

	current_jump_time += delta

	if current_jump_time >= jump_time_amount:
		emit_signal("queried_transition_to", "Run", { "emit_splash": true })


func get_jump_height() -> float:
	return jump_curve.interpolate(current_jump_time / jump_time_amount) * JUMP_HEIGHT
