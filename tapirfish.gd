extends KinematicBody2D

onready var x_max = get_viewport().get_visible_rect().size[0]
onready var y_max = get_viewport().get_visible_rect().size[1]
onready var timer: Timer = get_node("Timer")
onready var sprite: Sprite = get_node("Sprite")

var agent := GSAIKinematicBody2DAgent.new(self)

var _accel := GSAITargetAcceleration.new()
onready var _pursue: GSAIPursue = GSAIPursue.new(agent, get_node("/root/Main/Jelly").agent)
var _blend := GSAIBlend.new(agent)

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")

	_blend.add(_pursue, 5)

	agent.movement_type = GSAIKinematicBody2DAgent.MovementType.COLLIDE

	agent.linear_speed_max = 500.0
	agent.linear_acceleration_max = 500.0
	agent.linear_drag_percentage = 0.1
	agent.angular_speed_max = 100.0
	agent.angular_acceleration_max = 100.0
	agent.angular_drag_percentage = 0.3
	#_arrive.deceleration_radius = deg2rad(1.0)
	#_arrive.arrival_tolerance = 1.0


func _physics_process(delta: float) -> void:
	_blend.calculate_steering(_accel)
	agent._apply_steering(_accel, delta)

	if agent.collisionObject:
		print(agent.collisionObject)

	if _accel.linear.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func _on_timer_timeout():
	var target: GSAISteeringAgent = get_node("/root/Main/Jelly").agent
	_pursue.target = target
