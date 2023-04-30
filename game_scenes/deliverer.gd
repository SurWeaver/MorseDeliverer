class_name Deliverer
extends Area2D


const StepSplashScene = preload("res://effects/step_splash.tscn")

export var speed: float = 300

export var outer_effect_node_path: NodePath
onready var outer_effect_node = get_node(outer_effect_node_path)


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


func toggle_slide_effect_visibility(visibility: bool) -> void:
	for child in $SlideEffects.get_children():
		(child as CPUParticles2D).emitting = visibility

func toggle_slide_collision(is_sliding: bool) -> void:
	$StandCollision.set_deferred("disabled", is_sliding)
	$SlideCollision.set_deferred("disabled", not is_sliding)


func _on_deliverer_area_entered(area: Area2D) -> void:
	if area.is_in_group("obstacle"):
		$StateMachine.transition_to("Fall")
	if area.is_in_group("finish"):
		$StateMachine.transition_to("Finish")
