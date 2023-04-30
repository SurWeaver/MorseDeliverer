extends AudioStreamPlayer

export var sound_count: int
export var asset_path: String

export var force_play: bool

func play_random() -> void:
	if playing and not force_play:
		return

	randomize_current_stream()
	play()

func randomize_current_stream() -> void:
	stream = load(asset_path % Random.get_int(1, sound_count))
