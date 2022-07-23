extends KinematicBody2D
#extends RigidBody2D

onready var timer: Timer = get_node("Timer")

var cool = 10


func _ready() -> void:
	#self.connect("body_entered", self, "_on_body_entered")
	timer.connect("timeout", self, "_on_timer_timeout")


func _physics_process(delta):
	self.rotation_degrees += cool * delta
	self.global_position.y += 10 * delta


func _on_timer_timeout() -> void:
	if cool > 0:
		cool = -10
	else:
		cool = 10

#func _on_body_entered(body: Node):
#	print("collision")
#	var squid = body.collider as Squid
#	if squid:
#		squid.catch()
#		return
#
#	body.queue_free()
