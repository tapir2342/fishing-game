class_name Fish
extends KinematicBody2D

export var speed_max := 300
export var acceleration_max := 300
export var angular_speed_max := 5000
export var angular_acceleration_max := 5000

onready var jelly: Node = get_node("/root/Main/Jelly")
onready var jelly_agent: GSAISteeringAgent = jelly.agent

var agent: GSAISteeringAgent
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
	agent.linear_speed_max = speed_max
	agent.linear_acceleration_max = acceleration_max
	agent.angular_speed_max = deg2rad(angular_speed_max)
	agent.angular_acceleration_max = deg2rad(angular_acceleration_max)
	#agent.bounding_radius = calculate_radius($CollisionPolygon2D.polygon)

	var look := GSAILookWhereYouGo.new(agent)
	look.alignment_tolerance = deg2rad(5)
	look.deceleration_radius = deg2rad(60)

	var flee := GSAIFlee.new(agent, jelly_agent)

	all_agents.remove(index)
	var prox := GSAIRadiusProximity.new(agent, all_agents, 100)
	# var prox := GSAIProximity.new(agent, larvae)
	var separation := GSAISeparation.new(agent, prox)
	separation.decay_coefficient = 20000

	blend.add(look, 3)
	blend.add(flee, 8)
	blend.add(separation, 1)

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



