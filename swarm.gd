extends Node2D

onready var timer : Timer = get_node("Timer")

const Fish = preload("res://fish.tscn")

const SPAWN_MIN := 20
const SPAWN_MAX := 30

var x_max: int
var y_max: int

func _ready():
	timer.connect("timeout", self, "_spawn_fishes")

	x_max = get_viewport().get_visible_rect().size[0]
	y_max = get_viewport().get_visible_rect().size[1]

	_spawn_fishes()


func _spawn_fishes():
	var num = int(rand_range(SPAWN_MIN, SPAWN_MAX))
	for _i in range(0, num):
		var fish = Fish.instance()

		fish.agent.linear_speed_max = rand_range(5, 15)
		fish.agent.linear_acceleration_max = rand_range(5, 30)
		fish.agent.angular_speed_max = deg2rad(rand_range(30, 50))
		fish.agent.angular_acceleration_max = deg2rad(rand_range(30, 50))

		add_child(fish)
		fish.set_as_toplevel(true)

		fish.target.position = Vector3(x_max + 50, rand_range(300, 900), 0)
		fish.global_position.x = -50
		fish.global_position.y = rand_range(0, y_max)
