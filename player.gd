extends Node2D

export var speed := 100


func _process(delta):
	var velocity: float = self.speed * delta
	if Input.is_action_pressed("player_left"):
		self.position.x -= velocity
	if Input.is_action_pressed("player_right"):
		self.position.x += velocity
