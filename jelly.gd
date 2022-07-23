class_name Jelly
extends KinematicBody2D

onready var x_max = get_viewport().get_visible_rect().size[0]
onready var y_max = get_viewport().get_visible_rect().size[1]
onready var timer: Timer = get_node("Timer")

var agent := GSAIKinematicBody2DAgent.new(self, GSAIKinematicBody2DAgent.MovementType.COLLIDE)
var target := GSAIAgentLocation.new()

var _accel := GSAITargetAcceleration.new()
#var _velocity := Vector2()

var _arrive := GSAIArrive.new(agent, target)
var _look := GSAILookWhereYouGo.new(agent)
var _blend := GSAIBlend.new(agent)

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")

	_look.alignment_tolerance = deg2rad(5)
	_look.deceleration_radius = deg2rad(60)

	_blend.add(_arrive, 5)
	_blend.add(_look, 10)

	agent.linear_speed_max = 500.0
	agent.linear_acceleration_max = 500.0
	agent.linear_drag_percentage = 0.1
	agent.angular_speed_max = 100.0
	agent.angular_acceleration_max = 100.0
	agent.angular_drag_percentage = 0.3
	_arrive.deceleration_radius = deg2rad(1.0)
	_arrive.arrival_tolerance = 1.0


func _physics_process(delta: float) -> void:
	_blend.calculate_steering(_accel)
	agent._apply_steering(_accel, delta)


func _on_timer_timeout():
	target.position.x = rand_range(0, x_max)
	target.position.y = rand_range(0, y_max)
