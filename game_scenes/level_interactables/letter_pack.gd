class_name LetterPack
extends Node2D


const SYMBOL_MARGIN: float = 300.0
const CHECK_AREA_MARGIN: float = 20.0

const ObjectContainerScene = preload("res://game_scenes/level_interactables/object_container.tscn")
const SymbolScene = preload("res://game_scenes/level_interactables/symbol.tscn")
const DelivererCheckArea = preload("res://game_scenes/support_scenes/deliverer_check_area.tscn")


var saved_letter_code: String
var gathered_symbol_indexes := PoolIntArray()
var gathered_message: String

func add_symbols(letter_code: String) -> void:
	saved_letter_code = letter_code
	for i in range(letter_code.length()):
		var character = letter_code[i]
		var character_position = Vector2(SYMBOL_MARGIN * i, 0)

		var container = ObjectContainerScene.instance()
		container.position = character_position
		add_child(container)

		var symbol = _get_symbol_scene(character)
		symbol.symbol_index = i
		container.add_symbol(symbol)
		symbol.connect("player_picked_symbol", self, "_on_player_picked_symbol")
	add_check_area(letter_code.length())


func _get_symbol_scene(character: String) -> Symbol:
	var symbol = SymbolScene.instance()
	symbol.set_symbol_type(Symbol.Type.DASH if character == "-" else Symbol.Type.DOT)
	return symbol

func add_check_area(symbol_count: int) -> void:
	var check_area = DelivererCheckArea.instance()
	var distance = SYMBOL_MARGIN * symbol_count + CHECK_AREA_MARGIN
	check_area.position = Vector2.RIGHT * distance
	check_area.connect("area_entered", self, "_on_player_passed_pack")
	add_child(check_area)


func _on_player_picked_symbol(symbol: Symbol) -> void:
	gathered_symbol_indexes.append(symbol.symbol_index)

func _on_player_passed_pack(area: Area2D) -> void:
	gathered_message = ""
	for i in saved_letter_code.length():
		if i in gathered_symbol_indexes:
			gathered_message += saved_letter_code[i]
		else:
			gathered_message += "x"

func get_last_symbol_x() -> float:
	return get_child(get_child_count() - 1).position.x
