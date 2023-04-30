extends Node

signal finished

const ObstacleScene = preload("res://game_scenes/level_interactables/obstacle.tscn")


func _on_message_creator_finished() -> void:
	var object_containers = get_tree().get_nodes_in_group("object_container")

	var all_places = []

	for container in object_containers:
		var places = (container as ObjectContainer).get_available_positions()
		all_places.append_array(places)

	var place_fill_amount = int(floor(LevelInfo.obstacle_percentage * all_places.size()))

	randomize()
	all_places.shuffle()

	for i in range(place_fill_amount):
		var obstacle = ObstacleScene.instance()
		all_places[i].add_child(obstacle)

	emit_signal("finished")
	queue_free()
