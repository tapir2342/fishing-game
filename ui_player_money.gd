extends Control

export var _game_state: Resource = _game_state as GameState

onready var _label_value: Label = get_node("HBoxContainer/Value")


func _ready():
	GameEvents.connect("player_money_changed", self, "_on_player_money_changed")


func _on_player_money_changed(_old: int, value: int):
	_label_value.text = str(value)
