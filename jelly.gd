extends KinematicBody2D

export var speed_max := 100.0
export var acceleration_max := 100.0
export var angular_speed_max := 5000.0
export var angular_acceleration_max := 5000.0

onready var agent := GSAISteeringAgent.new()
onready var arrive: GSAIArrive
#onready var seek: GSAISeek
onready var blend: GSAIBlend

var velocity := Vector2.ZERO
var angular_velocity := 0.0
var linear_drag := 0.1
var angular_drag := 0.1
var acceleration := GSAITargetAcceleration.new()
var target := GSAIAgentLocation.new()

onready var x_max = get_viewport().get_visible_rect().size[0]
onready var y_max = get_viewport().get_visible_rect().size[1]

onready var timer : Timer = get_node("Timer")

func _ready():
	agent.linear_speed_max = speed_max
	agent.linear_acceleration_max = acceleration_max
	agent.angular_speed_max = deg2rad(angular_speed_max)
	agent.angular_acceleration_max = deg2rad(angular_acceleration_max)

	timer.connect("timeout", self, "_on_timer_timeout")

	var look := GSAILookWhereYouGo.new(agent)
	look.alignment_tolerance = deg2rad(5)
	look.deceleration_radius = deg2rad(60)

	arrive = GSAIArrive.new(agent, target)

	blend = GSAIBlend.new(agent)
	blend.add(arrive, 5)
	blend.add(look, 10)

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


func _on_timer_timeout():

	target.position.x = rand_range(0, x_max)
	target.position.y = rand_range(0, y_max)
