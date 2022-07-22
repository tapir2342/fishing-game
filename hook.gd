extends RigidBody2D


func _process(delta: float) -> void:
	var cool := delta * 10.0

	if Input.is_action_pressed("player_up"):
		self.apply_central_impulse(Vector2(0, -10))
		#self.position.y -= cool

	if Input.is_action_pressed("player_down"):
		#self.position.y += cool
		self.apply_central_impulse(Vector2(0, 10))
