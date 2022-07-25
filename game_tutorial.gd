extends State

export var tutorial_path: NodePath

onready var _tutorial: Tutorial = get_node(tutorial_path)


func enter(_msg := {}) -> void:
	Engine.time_scale = 0
	_tutorial.show()
	_tutorial.connect("confirmed", self, "_on_tutorial_confirmed")


func exit() -> void:
	Engine.time_scale = 1
	_tutorial.hide()
	_tutorial.disconnect("confirmed", self, "_on_tutorial_confirmed")


func _on_tutorial_confirmed() -> void:
	state_machine.transition_to("Loop")
