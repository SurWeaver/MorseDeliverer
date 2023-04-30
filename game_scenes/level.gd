extends Node2D


var can_restart_or_exit: bool = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart") and can_restart_or_exit:
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("exit") and can_restart_or_exit:
		get_tree().change_scene("res://ui_scenes/main_menu.tscn")

func _on_deliverer_finished_level() -> void:
	$MessageSpeller.set_talk_position($Deliverer.get_mouth_position())
	var gathered_messages = get_gathered_messages()
	$MessageSpeller.say(gathered_messages)

func get_gathered_messages() -> Array:
	var gathered_messages = []
	for node in get_tree().get_nodes_in_group("letter_pack"):
		gathered_messages.append(node.gathered_message)
	return gathered_messages


func _on_message_speller_finished() -> void:
	$Deliverer.play_animation("idle")
	can_restart_or_exit = true
	$CanvasLayer/RestartOrExitMenu.show()
	$CanvasLayer/ResultMenu.update_from_gathered_messages(get_gathered_messages())
	$CanvasLayer/ResultMenu.show()

func _on_message_speller_letter_spelled(symbols: String) -> void:
	var letter = Morse.get_character_from_morse(symbols)

	$CanvasLayer/MessageVisualizer.add_letter(letter)

func _on_deliverer_fell() -> void:
	can_restart_or_exit = true
	$CanvasLayer/RestartOrExitMenu.show()
	$CanvasLayer/ResultMenu.update_from_gathered_messages(get_gathered_messages())
	$CanvasLayer/ResultMenu.show()
