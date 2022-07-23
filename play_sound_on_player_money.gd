extends Node2D

onready var _audio_player = get_node("AudioStreamPlayer")
onready var _game_state: Resource = _game_state as GameState


func _ready():
	GameEvents.connect("player_money_changed", self, "_on_player_money_changed")


func _on_player_money_changed(old: int, new: int):
	if new > old:
		_audio_player.play()
