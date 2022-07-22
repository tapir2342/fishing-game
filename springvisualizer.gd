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


	line.clear_points()
	line.add_point(actual_node_a.global_position)
	line.add_point(actual_node_b.global_position)
