extends Node2D


const Jelly := preload("res://jelly.tscn")
const Squid := preload("res://squid.tscn")


onready var _timer_jelly: Timer = get_node("TimerJelly")
onready var _timer_squid: Timer = get_node("TimerSquid")

var x_max: int
var y_max: int


func _ready():
	_timer_jelly.connect("timeout", self, "_spawn_jelly")
	_timer_squid.connect("timeout", self, "_spawn_squid")

	x_max = get_viewport().get_visible_rect().size[0]
	y_max = get_viewport().get_visible_rect().size[1]


func _spawn_jelly():
	_spawn_fish(Jelly.instance())


func _spawn_squid():
	_spawn_fish(Squid.instance())


func _spawn_fish(fish: Node2D):
	fish.set_as_toplevel(true)
	add_child(fish)
	fish.global_position.x = rand_range(200, x_max - 200)
	fish.global_position.y = rand_range(300, y_max - 200)
