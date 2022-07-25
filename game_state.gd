class_name GameState
extends Resource

export var player_score: int = 0 setget _set_player_score
export var tapir_score: int = 0 setget _set_tapir_score


func _set_player_score(value):
	var old = player_score
	player_score = value
	GameEvents.emit_signal("player_score_changed", old, value)


func _set_tapir_score(value):
	var old = tapir_score
	tapir_score = value
	GameEvents.emit_signal("tapir_score_changed", old, value)
