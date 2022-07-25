extends State


export var countdown_path: NodePath

onready var _countdown: Countdown = get_node(countdown_path)


func enter(_msg := {}) -> void:
	_countdown.start()
	_countdown.connect("done", self, "_on_countdown_done")


func exit() -> void:
	get_node("/root/Main/AudioStreamPlayer").stop()


func _on_countdown_done() -> void:
	state_machine.transition_to("WinOrLose")
