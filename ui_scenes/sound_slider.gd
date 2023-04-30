extends HSlider

onready var sound_bus_index = AudioServer.get_bus_index("Sounds")

func _ready() -> void:
	var db_volume = AudioServer.get_bus_volume_db(sound_bus_index)

	value = db2linear(db_volume)

func _on_sound_slider_value_changed(value: float) -> void:
	var db_volume = linear2db(value)
	AudioServer.set_bus_volume_db(sound_bus_index, db_volume)


func _on_button_pressed() -> void:
	$RandomAudioPlayer.play_random()
