extends Control


const AppearingLetterScene = preload("res://ui_scenes/appearing_letter.tscn")


onready var current_container = $MarginContainer/VBoxContainer/HBoxContainer

func add_letter(letter: String) -> void:
	if letter == " ":
		create_new_container()
		return

	var letter_label = AppearingLetterScene.instance()
	letter_label.text = letter
	current_container.add_child(letter_label)

func create_new_container() -> void:
	current_container = HBoxContainer.new()
	current_container.size_flags_vertical = 0
	$MarginContainer/VBoxContainer.add_child(current_container)
	pass
