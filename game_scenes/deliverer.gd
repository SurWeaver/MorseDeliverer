class_name Deliverer
extends Area2D

signal fell
signal finished_level

const StepSplashScene = preload("res://effects/step_splash.tscn")


export var speed: float = 300

export var outer_effect_node_path: NodePath
onready var outer_effect_node = get_node(outer_effect_node_path)

var is_queried_to_relax: bool = false

func get_mouth_position() -> Vector2:
	return $Character/Sprite/Mouth.global_position

func move(delta: float):
	position.x += speed * delta

func play_animation(animation_name: String) -> void:
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
	$AnimationPlayer.play(animation_name)


func emit_front_step_splash() -> void:
	emit_step_splash($Character/Sprite/FrontLeg)

func emit_back_step_splash() -> void:
	emit_step_splash($Character/Sprite/BackLeg)

func emit_step_splash(position_node: Position2D) -> void:
	var splash = StepSplashScene.instance()
	splash.global_position = position_node.global_position
	outer_effect_node.add_child(splash)


func _on_state_machine_transitioned(old_state_name: String, new_state_name: String) -> void:
	var is_sliding = (new_state_name == "Slide")

	toggle_slide_effect_visibility(is_sliding)
	toggle_slide_collision(is_sliding)

	if new_state_name == "Finish":
		emit_signal("finished_level")
	if new_state_name == "Fall":
		emit_signal("fell")

	if old_state_name == "Slide":
		$SlidePlayer.stop()
	elif new_state_name == "Slide":
		$SlidePlayer.play()
	elif new_state_name == "Relax":
		$RelaxPlayer.play_random()


func toggle_slide_effect_visibility(visibility: bool) -> void:
	for child in $SlideEffects.get_children():
		(child as CPUParticles2D).emitting = visibility

func toggle_slide_collision(is_sliding: bool) -> void:
	$StandCollision.set_deferred("disabled", is_sliding)
	$SlideCollision.set_deferred("disabled", not is_sliding)


func _on_deliverer_area_entered(area: Area2D) -> void:
	if area.is_in_group("obstacle"):
		$StateMachine.transition_to("Fall")
		$FallPlayer.play_random()

		$StandCollision.set_deferred("disabled", true)
		$SlideCollision.set_deferred("disabled", true)
	elif area.is_in_group("finish"):
		is_queried_to_relax = true
	elif area.is_in_group("symbol") and $StateMachine.state.name != "Fall":
		$EatPlayer.play_random()
