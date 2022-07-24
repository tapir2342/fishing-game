class_name Squid
extends KinematicBody2D

onready var machine: StateMachine = get_node("StateMachine")

onready var x_max = get_viewport().get_visible_rect().size[0]
onready var y_max = get_viewport().get_visible_rect().size[1]
onready var timer: Timer = get_node("Timer")
onready var sprite: Sprite = get_node("Sprite")

var agent := GSAIKinematicBody2DAgent.new(self, GSAIKinematicBody2DAgent.MovementType.COLLIDE)
var target := GSAIAgentLocation.new()
var accel := GSAITargetAcceleration.new()
var arrive := GSAIArrive.new(agent, target)
var blend := GSAIBlend.new(agent)


func catch():
	machine.transition_to("Caught")
