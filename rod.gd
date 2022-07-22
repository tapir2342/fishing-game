extends Node2D

onready var hook: KinematicBody2D = get_node("/root/Main/Hook")


func _process(delta) -> void:
	var dir_hook_to_rod := (self.global_position - hook.global_position).normalized()
	var collision: KinematicCollision2D

	if Input.is_action_pressed("player_up"):
		collision = hook.move_and_collide(dir_hook_to_rod * 10)

	if Input.is_action_pressed("player_down"):
		collision = hook.move_and_collide(Vector2(0, 10))

	if collision:
		var squid = collision.collider as Squid
		if squid:
			squid.catch()
