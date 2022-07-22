extends Node2D


const Fish = preload("res://fish.tscn")

var fishes = []


func _ready():
	var num = 50
	var x_max = get_viewport().get_visible_rect().size[0]
	var y_max = get_viewport().get_visible_rect().size[1]

	for _i in range(0, num):
		var fish = Fish.instance()
		fish.global_position.x = rand_range(0, x_max)
		fish.global_position.y = rand_range(0, y_max)
		fish.acceleration_max = 10
		fish.angular_acceleration_max = 10
		fish.angular_speed_max = 10
		fish.speed_max = 10
		add_child(fish)
		fish.set_as_toplevel(true)
		fishes.append(fish)


func _physics_process(delta):
	for fish in fishes:
		fish.global_position.x += rand_range(0, 1)
		fish.global_position.y += rand_range(0, 1)
