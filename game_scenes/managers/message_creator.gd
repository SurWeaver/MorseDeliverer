extends Node


const INITIAL_MARGIN: float = 500.0
const SYMBOL_MARGIN: float = 300.0
const LETTER_MARGIN: float = 400.0

const LetterPackScene = preload("res://game_scenes/level_interactables/letter_pack.tscn")
const FinishScene = preload("res://game_scenes/level_interactables/finish.tscn")

signal finished


export var node_with_letter_packs_path: NodePath

onready var node_with_letter_packs = get_node(node_with_letter_packs_path)


func _ready():
	var encoded_message = Morse.get_morse_message_symbols(LevelInfo.message_to_deliver)
	print(encoded_message)

	var iter_position = Vector2(INITIAL_MARGIN, 0)

	for letter_code in encoded_message:
		print(letter_code)
		if letter_code == " ":
			iter_position += Vector2.RIGHT * LETTER_MARGIN
			continue

		var letter_pack = LetterPackScene.instance()
		letter_pack.position = iter_position
		letter_pack.add_symbols(letter_code)
		node_with_letter_packs.add_child(letter_pack)

		iter_position += Vector2.RIGHT * (letter_pack.get_last_symbol_x() + LETTER_MARGIN)

	var finish = FinishScene.instance()
	finish.position = iter_position
	node_with_letter_packs.add_child(finish)

	print(get_tree().get_nodes_in_group("symbol"))

	emit_signal("finished")
	queue_free()
