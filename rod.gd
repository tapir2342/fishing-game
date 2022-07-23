extends Node2D

onready var hook: KinematicBody2D = get_node("/root/Main/Hook")

var collision: KinematicCollision2D
var target: Vector2 = Vector2.ZERO
var speed := 50
var t := 0.0
var up := false
var down := false
var new_pos: Vector2


func _process(delta) -> void:
	up = Input.is_action_pressed("player_up")
	down = Input.is_action_pressed("player_down")

	if up and not down:
		target = (self.global_position - hook.global_position).normalized() * speed

	if down and not up:
		target.y = speed

	t += delta * 0.5
	target = Vector2.linear_interpolate(target, t)

	if up or down:
		# Kinematic:
		collision = hook.move_and_collide(target)
		# Rigidbody:
		#hook.apply_central_impulse(target)

		if collision:
			var squid = collision.collider as Squid
			if squid:
				squid.catch()
				return

			collision.collider.queue_free()
	else:
		t = 0.0
