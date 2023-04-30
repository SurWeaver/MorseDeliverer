extends Node2D

signal finished

signal letter_spelled(symbols)


const TalkParticleScene = preload("res://effects/talk_particle.tscn")


onready var talk_position: Vector2 = Vector2(300, 300)



func set_talk_position(pos: Vector2) -> void:
	talk_position = pos

func say(gathered_morse_array: Array) -> void:
	for symbols in gathered_morse_array:
		if symbols == " ":
			emit_signal("letter_spelled", symbols)
			yield(get_tree().create_timer(1), "timeout")
			continue
		for character in symbols:
			var length = 0.3 if character == "." or character == "x" else 0.6
			yield(get_tree().create_timer(length), "timeout")
			say_symbol(character)
		emit_signal("letter_spelled", symbols)
		yield(get_tree().create_timer(0.2), "timeout")

	emit_signal("finished")

func say_symbol(symbol: String) -> void:
	var talk_symbol = TalkParticleScene.instance()
	talk_symbol.global_position = talk_position
	talk_symbol.set_symbol(symbol)
	$SymbolParticles.add_child(talk_symbol)

	match symbol:
		".":
			$RandomDotPlayer.play_random()
		"-":
			$RandomDashPlayer.play_random()
		"x":
			$RandomWrongPlayer.play_random()
