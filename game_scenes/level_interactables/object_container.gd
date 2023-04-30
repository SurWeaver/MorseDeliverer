class_name ObjectContainer
extends Node2D


const MAX_OBSTACLE_COUNT = 2


var available_for_symbol: bool = true
var obstacle_count: int = 0


func add_symbol(symbol: Node2D) -> void:
	if not available_for_symbol:
		push_error("adding symbol while it's not available")
		return

	if Random.get_int(0, 1) == 1:
		$JumpPosition.add_child(symbol)
	else:
		$FloorPosition.add_child(symbol)

	available_for_symbol = false

func add_obstacle(obstacle: Node2D) -> void:
	if obstacle_count == MAX_OBSTACLE_COUNT:
		push_error("adding obstacle while it's not available")
		return

	var available_position = get_single_available_position()

	available_position.add_child(obstacle)
	obstacle_count += 1

func get_single_available_position() -> Position2D:
	var available_positions = get_available_positions()
	var rand_index = Random.get_int(0, available_positions.size() - 1)

	return available_positions[rand_index]

func get_available_positions() -> Array:
	var available_positions = []

	for position_node in get_children():
		if position_node.get_child_count() == 0:
			available_positions.append(position_node)

	return available_positions
