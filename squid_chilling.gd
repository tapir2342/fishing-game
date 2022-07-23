extends State


func enter(_msg := {}) -> void:
	owner.timer.connect("timeout", self, "_on_timer_timeout")

	owner.blend.add(owner.arrive, 5)

	owner.agent.linear_speed_max = 500.0
	owner.agent.linear_acceleration_max = 500.0
	owner.agent.linear_drag_percentage = 0.1
	owner.agent.angular_speed_max = 100.0
	owner.agent.angular_acceleration_max = 100.0
	owner.agent.angular_drag_percentage = 0.3
	owner.arrive.deceleration_radius = deg2rad(1.0)
	owner.arrive.arrival_tolerance = 1.0


func physics_process(delta: float) -> void:
	owner.blend.calculate_steering(owner.accel)
	owner.agent._apply_steering(owner.accel, delta)

	if owner.accel.linear.x < 0:
		owner.sprite.flip_h = true
	else:
		owner.sprite.flip_h = false


func _on_timer_timeout():
	owner.target.position.x = rand_range(0, owner.x_max)
	owner.target.position.y = rand_range(0, owner.y_max)
	owner.timer.wait_time = rand_range(0, 5)


func exit() -> void:
	owner.timer.disconnect("timeout", self, "_on_timer_timeout")
