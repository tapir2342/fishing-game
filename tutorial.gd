class_name Tutorial
extends CanvasLayer

signal confirmed

export var confirmation_button_path: NodePath

onready var _control := get_node("Control")
onready var _confirmation_button: Button = get_node(confirmation_button_path)


func _ready() -> void:
	_confirmation_button.connect("pressed", self, "_on_confirmation_button_pressed")


func _on_confirmation_button_pressed() -> void:
	self.emit_signal("confirmed")


func show() -> void:
	_control.visible = true


func hide() -> void:
	_control.visible = false
