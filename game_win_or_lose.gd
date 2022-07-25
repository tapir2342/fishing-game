extends State

export var game_state: Resource = game_state as GameState
export var win_or_lose_path: NodePath

onready var _win_or_lose: WinOrLose = get_node(win_or_lose_path)


func enter(_msg := {}) -> void:
	Engine.time_scale = 0
	if game_state.player_score >= game_state.tapir_score:
		_win_or_lose.victory()
	else:
		_win_or_lose.defeat()
