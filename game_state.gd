class_name GameState
extends Resource

export var player_money: int = 0 setget _set_player_money


func _set_player_money(value):
	var old = player_money
	player_money = value
	print("changing player_money...")
	GameEvents.emit_signal("player_money_changed", old, value)
