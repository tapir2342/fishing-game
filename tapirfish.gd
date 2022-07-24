extends KinematicBody2D

onready var x_max = get_viewport().get_visible_rect().size[0]
onready var y_max = get_viewport().get_visible_rect().size[1]
onready var timer: Timer = get_node("Timer")
onready var sprite: Sprite = get_node("Sprite")

var agent := GSAIKinematicBody2DAgent.new(self, GSAIKinematicBody2DAgent.MovementType.COLLIDE)
var _accel := GSAITargetAcceleration.new()

# Pursuing if there are jellies.
var _pursue: GSAIPursue

# Otherwise seek random point.
var _seek: GSAISeek


func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")

	agent.linear_speed_max = 700.0
	agent.linear_acceleration_max = 700.0
	agent.linear_drag_percentage = 0.1
	agent.angular_speed_max = 100.0
	agent.angular_acceleration_max = 100.0
	agent.angular_drag_percentage = 0.3
	agent.bounding_radius = 5.0
	#_arrive.deceleration_radius = deg2rad(1.0)
	#_arrive.arrival_tolerance = 1.0

	_seek_random_point()


func _physics_process(delta: float) -> void:
	_look()

	if _pursue:
		_pursue.calculate_steering(_accel)
	else:
		if _seek:
			_seek.calculate_steering(_accel)

	agent._apply_steering(_accel, delta)

	if agent.collisionObject:
		var jelly = agent.collisionObject.collider as Jelly
		if jelly:
			_pursue = null
			jelly.queue_free()


func _look() -> void:
	sprite.flip_h = _accel.linear.x > 0


func _on_timer_timeout() -> void:
	var foo = Vector3()
	foo.x = self.global_position.x
	foo.y = self.global_position.y
	if _pursue and _pursue.target.position.distance_to(foo) < 100.0:
		print(_pursue.target.position.distance_to(foo))
		return

	var jellies = get_tree().get_nodes_in_group("Jellies")

	if len(jellies) > 0:
		_pursue_random_jelly(jellies)
	else:
		_seek_random_point()


func _pursue_random_jelly(jellies: Array):
	if len(jellies) == 0:
		return

	var target: GSAISteeringAgent = jellies[randi() % len(jellies)].agent
	_pursue = GSAIPursue.new(agent, target)


func _seek_random_point():
	var v = Vector3()
	v.x = rand_range(200, x_max - 200)
	v.y = rand_range(300, y_max - 300)

	var target := GSAIAgentLocation.new()
	target.position = v

	_pursue = null
	_seek = GSAISeek.new(agent, target)
