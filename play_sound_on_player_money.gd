extends Node2D

onready var _audio_player = get_node("AudioStreamPlayer")


func _ready():
	GameEvents.connect("player_score_changed", self, "_on_player_score_changed")


func _on_player_score_changed(old: int, new: int):
	if new > old:
		_audio_player.play()
