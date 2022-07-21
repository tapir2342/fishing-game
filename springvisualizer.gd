extends DampedSpringJoint2D

onready var line: Line2D = get_node("/root/Main/Line2D")

onready var actual_node_a: Node2D = get_node(node_a)
onready var actual_node_b: Node2D = get_node(node_b)


func _ready():
	print(line)
	line.set_as_toplevel(true)

	print(actual_node_a)
	print(actual_node_b)


func _physics_process(_delta):
	if Input.is_action_pressed("player_up"):
		rest_length -= 1
		rest_length = clamp(rest_length, 0, 65535)

	if Input.is_action_pressed("player_down"):
		rest_length += 1
		rest_length = clamp(rest_length, 0, 65535)

	line.clear_points()
	line.add_point(actual_node_a.global_position)
	line.add_point(actual_node_b.global_position)
