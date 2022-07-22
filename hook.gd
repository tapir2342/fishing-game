extends KinematicBody2D


onready var rod_tip: Node2D = get_node("/root/Main/Player/Rod/Tip")
onready var timer: Timer = get_node("Timer")



func _process(_delta) -> void:
	#self.rotate(rod_tip.global_position.angle_to(self.global_position))
	#self.rotate(self.global_position.angle_to(rod_tip.global_position))
	pass
