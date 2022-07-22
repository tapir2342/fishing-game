class_name StateMachine
extends Node

export var initial_state := NodePath()

onready var state: Node = get_node(initial_state)


func _ready() -> void:
	print("StateMachine: initial_state: ", state)
	yield(self.owner, "ready")
	self.state.enter()


func _unhandled_input(event: InputEvent) -> void:
	self.state.handle_input(event)


func _process(delta: float) -> void:
	self.state.process(delta)


func _physics_process(delta: float) -> void:
	self.state.physics_process(delta)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not self.has_node(target_state_name):
		var error_msg = "State not found: %s" % target_state_name
		print(error_msg)
		push_error(error_msg)
		return

	self.state.exit()
	self.state = get_node(target_state_name)
	self.state.enter(msg)
