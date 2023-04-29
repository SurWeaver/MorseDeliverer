class_name StateMachine
extends Node


signal transitioned(old_state_name, new_state_name)


export var initial_state: NodePath

var state: State


func _ready() -> void:
	yield(owner, "ready")
	for child in get_children():
		(child as State).connect("queried_transition_to", self, "transition_to")
	state = get_node(initial_state)
	state._enter()


func _unhandled_input(event: InputEvent):
	state._handle_input(event)

func _process(delta: float):
	state._update(delta)

func _physics_process(delta: float):
	state._physics_update(delta)


func transition_to(target_state_name: String, message: Dictionary = {}):
	if not has_node(target_state_name):
		return

	var old_state_name = state.name
	state._exit()
	state = get_node(target_state_name)
	state._enter(message)
	emit_signal("transitioned", old_state_name, state.name)
