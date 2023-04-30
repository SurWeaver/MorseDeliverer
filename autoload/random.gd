extends Node

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()

func get_float(from: float, to: float) -> float:
	return rng.randf_range(from, to)

func get_int(from: int, to: int) -> int:
	return rng.randi_range(from, to)
