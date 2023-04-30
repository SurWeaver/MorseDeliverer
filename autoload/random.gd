extends Node

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()

func get_float(from: float, to: float) -> float:
	return rng.randf_range(from, to)
