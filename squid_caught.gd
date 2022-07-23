extends State

onready var hook: Node2D = get_node("/root/Main/Hook")
onready var cs: CollisionShape2D = owner.get_node("CollisionShape2D")


func enter(_msg := {}) -> void:
	owner.get_parent().remove_child(owner)
	owner.position.x = 0
	owner.position.y = 0
	cs.disabled = true
	hook.add_child(owner)
