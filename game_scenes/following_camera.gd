extends Camera2D

export var following_node_path: NodePath

onready var following_node = get_node(following_node_path)

func _process(delta: float) -> void:
	global_position.x = following_node.global_position.x
