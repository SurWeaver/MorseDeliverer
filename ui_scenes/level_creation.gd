extends Control


var regex = RegEx.new()

onready var line_edit = $CenterContainer/VBoxContainer/VBoxContainer2/LineEdit

func _ready() -> void:
	LevelInfo.obstacle_percentage = $CenterContainer/VBoxContainer/VBoxContainer/HSlider.value

func _on_return_button_pressed() -> void:
	get_tree().change_scene("res://ui_scenes/main_menu.tscn")


func _on_line_edit_text_changed(_new_text: String) -> void:
	$CenterContainer/VBoxContainer/StartButton.disabled = true

func _on_apply_button_pressed() -> void:
	var new_text = line_edit.text
	new_text = new_text.to_lower()
	regex.compile("(?![a-zA-Z0-9!?.,;:+\\-\\/= ]).")
	new_text = regex.sub(new_text, "", true)
	line_edit.text = new_text

	LevelInfo.message_to_deliver = new_text
	$CenterContainer/VBoxContainer/StartButton.disabled = false


func _on_hslider_value_changed(value: float) -> void:
	LevelInfo.obstacle_percentage = value

func _on_start_button_pressed() -> void:
	get_tree().change_scene("res://game_scenes/level.tscn")
