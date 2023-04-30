extends Control


func go_to_level(text: String, obstacle_percentage: float) -> void:
	LevelInfo.message_to_deliver = text
	LevelInfo.obstacle_percentage = obstacle_percentage
	get_tree().change_scene("res://game_scenes/level.tscn")


func _on_create_level_button_pressed() -> void:
	get_tree().change_scene("res://ui_scenes/level_creation.tscn")
