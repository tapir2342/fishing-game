extends State

onready var hook: Node2D = get_node("/root/Main/Hook")
onready var cs: CollisionShape2D = owner.get_node("CollisionShape2D")


func enter(_msg := {}) -> void:
	print("Squid caught: %s" % self)
	owner.get_parent().remove_child(owner)
	cs.disabled = true
	hook.add_child(owner)
