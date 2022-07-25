extends Control


func _ready() -> void:
	GameEvents.connect("tapir_score_changed", self, "_on_tapir_score_changed")


func _on_tapir_score_changed(old: int, new: int) -> void:
	$Label.text = str(new)

	if new > old:
		$TextureProgress.value += 5
