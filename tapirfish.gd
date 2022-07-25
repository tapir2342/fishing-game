extends KinematicBody2D

export var game_state: Resource = game_state as GameState

onready var x_max = get_viewport().get_visible_rect().size[0]
onready var y_max = get_viewport().get_visible_rect().size[1]
onready var timer: Timer = get_node("Timer")
onready var sprite: Sprite = get_node("Sprite")

var agent := GSAIKinematicBody2DAgent.new(self, GSAIKinematicBody2DAgent.MovementType.COLLIDE)

var _accel := GSAITargetAcceleration.new()

var _blend: GSAIBlend = GSAIBlend.new(agent)


func _ready():
	randomize()

	timer.connect("timeout", self, "_on_timer_timeout")

	agent.linear_speed_max = 750.0
	agent.linear_acceleration_max = 1000.0
	agent.linear_drag_percentage = 0.1
	agent.angular_speed_max = 100.0
	agent.angular_acceleration_max = 100.0
	agent.angular_drag_percentage = 0.3
	agent.bounding_radius = 5.0

	_decide()


func _physics_process(delta: float) -> void:
	_look()

	_blend.calculate_steering(_accel)
	agent._apply_steering(_accel, delta)

	if agent.collisionObject:
		var prey: Node2D = agent.collisionObject.collider
		if prey:
			$AudioStreamPlayer2D.play()
			prey.queue_free()
			_decide()
			game_state.tapir_score += 1


func _look() -> void:
	sprite.flip_h = _accel.linear.x > 10


func _decide():
	_blend = GSAIBlend.new(agent)

	var seek_target := _random_location()
	var seek = GSAISeek.new(agent, seek_target)
	_blend.add(seek, 3)

	var pursue_target := _random_prey()
	if pursue_target:
		var pursue := GSAIPursue.new(agent, pursue_target)
		_blend.add(pursue, 9)


func _on_timer_timeout():
	_decide()


func _random_prey() -> GSAISteeringAgent:
	var prey := get_tree().get_nodes_in_group("Prey")
	if len(prey) > 0:
		var random_prey: Node2D = prey[randi() % len(prey)]
		return random_prey.agent

	return null


func _random_location() -> GSAIAgentLocation:
	var v = Vector3()
	v.x = rand_range(200, x_max - 200)
	v.y = rand_range(300, y_max - 300)

	var location = GSAIAgentLocation.new()
	location.position = v

	return location
