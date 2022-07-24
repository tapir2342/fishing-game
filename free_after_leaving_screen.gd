extends VisibilityNotifier2D


func _ready():
	self.connect("screen_exited", self, "_on_screen_exited")


func _on_screen_exited() -> void:
	if owner:
		owner.queue_free()
