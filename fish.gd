class_name Fish
extends KinematicBody2D

var speed_max := 300
var acceleration_max := 300
var angular_speed_max := 5000
var angular_acceleration_max := 5000

onready var jelly: Node = get_node("/root/Main/Jelly")
onready var jelly_agent: GSAISteeringAgent = jelly.agent
onready var notifier: VisibilityNotifier2D = get_node("VisibilityNotifier2D") as VisibilityNotifier2D

onready var target := GSAIAgentLocation.new()

var agent: GSAISteeringAgent
var seek: GSAISeek
var blend: GSAIBlend

var velocity := Vector2.ZERO
var angular_velocity := 0.0
var linear_drag := 0.1
var angular_drag := 0.1
var acceleration := GSAITargetAcceleration.new()


var index: int

var all_agents: Array


func _init():
	agent = GSAISteeringAgent.new()
	blend = GSAIBlend.new(agent)


func _ready():
	notifier.connect("screen_exited", self, "_on_screen_exited")

	#agent.bounding_radius = calculate_radius($CollisionPolygon2D.polygon)

	var look := GSAILookWhereYouGo.new(agent)
	look.alignment_tolerance = deg2rad(5)
	look.deceleration_radius = deg2rad(60)

	var flee := GSAIFlee.new(agent, jelly_agent)

	if len(all_agents) > 0:
		all_agents.remove(index)
	var prox := GSAIRadiusProximity.new(agent, all_agents, 100)
	# var prox := GSAIProximity.new(agent, larvae)
	var separation := GSAISeparation.new(agent, prox)
	separation.decay_coefficient = 20000


	seek = GSAISeek.new(agent, target)

	blend.add(look, 8)
	blend.add(flee, 4)
	blend.add(separation, 1)
	blend.add(seek, 9)

	_update_agent()


func _physics_process(delta):
	# Changes acceleration in-place. Ew.
	blend.calculate_steering(acceleration)

	velocity = (velocity + Vector2(acceleration.linear.x, acceleration.linear.y) * delta).clamped(
		agent.linear_speed_max
	)
	velocity = velocity.linear_interpolate(Vector2.ZERO, linear_drag)

	var collision := move_and_collide(velocity)
	#if collision:
	#	self.queue_free()

	angular_velocity = clamp(
		angular_velocity + acceleration.angular * delta, -agent.angular_speed_max, agent.angular_speed_max
	)
	angular_velocity = lerp(angular_velocity, 0, angular_drag)
	rotation += angular_velocity * delta

	_update_agent()


func _update_agent() -> void:
	agent.position.x = global_position.x
	agent.position.y = global_position.y
	agent.orientation = rotation
	agent.linear_velocity.x = velocity.x
	agent.linear_velocity.y = velocity.y
	agent.angular_velocity = angular_velocity


func _on_screen_exited() -> void:
	queue_free()
