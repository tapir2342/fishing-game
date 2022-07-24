extends Node2D

const Jelly := preload("res://jelly.tscn")
const Squid := preload("res://squid.tscn")

export var jelly_num_max := 5
export var squid_num_max := 2

onready var _jelly_timer: Timer = get_node("TimerJelly")
onready var _squid_timer: Timer = get_node("TimerSquid")

var x_max: int
var y_max: int


func _ready():
	_jelly_timer.connect("timeout", self, "_jelly_spawn")
	_squid_timer.connect("timeout", self, "_squid_spawn")

	x_max = get_viewport().get_visible_rect().size[0]
	y_max = get_viewport().get_visible_rect().size[1]


func _jelly_spawn():
	if _jelly_num_current() < jelly_num_max:
		_spawn_fish(Jelly.instance())


func _squid_spawn():
	if _squid_num_current() < squid_num_max:
		_spawn_fish(Squid.instance())


func _jelly_num_current() -> int:
	return len(get_tree().get_nodes_in_group("Jellies"))


func _squid_num_current() -> int:
	return len(get_tree().get_nodes_in_group("Squids"))


func _spawn_fish(fish: Node2D):
	fish.set_as_toplevel(true)
	add_child(fish)
	fish.global_position.x = rand_range(200, x_max - 200)
	fish.global_position.y = rand_range(300, y_max - 200)
