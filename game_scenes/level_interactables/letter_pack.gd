class_name LetterPack
extends Node2D

const SYMBOL_MARGIN: float = 300.0

const ObjectContainerScene = preload("res://game_scenes/level_interactables/object_container.tscn")
const SymbolScene = preload("res://game_scenes/level_interactables/symbol.tscn")


func add_symbols(letter_code: String) -> void:
	for i in range(letter_code.length()):
		var character = letter_code[i]
		var character_position = Vector2(SYMBOL_MARGIN * i, 0)

		var container = ObjectContainerScene.instance()
		container.position = character_position
		add_child(container)

		var symbol = _get_symbol_scene(character)
		container.add_symbol(symbol)

func _get_symbol_scene(character: String) -> Symbol:
	var symbol = SymbolScene.instance()
	symbol.set_symbol_type(Symbol.Type.DASH if character == "-" else Symbol.Type.DOT)
	return symbol


func get_last_symbol_x() -> float:
	return get_child(get_child_count() - 1).position.x
