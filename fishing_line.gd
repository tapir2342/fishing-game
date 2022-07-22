extends Line2D

onready var start: Node2D = get_node("/root/Main/Player/Rod/Tip")
onready var end: Node2D = get_node("/root/Main/Hook")


func _ready():
	self.set_as_toplevel(true)


func _process(delta):
	self.clear_points()
	self.add_point(start.global_position)
	self.add_point(end.global_position)
