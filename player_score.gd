extends Control


func _ready() -> void:
	GameEvents.connect("player_score_changed", self, "_on_player_score_changed")


func _on_player_score_changed(old: int, new: int) -> void:
	$Label.text = str(new)

	if new > old:
		$TextureProgress.value += 5
