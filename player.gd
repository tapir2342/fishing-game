extends Node2D

export var _game_state: Resource = _game_state as GameState
export var speed := 100

onready var audio: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")


func _process(delta):
	var velocity: float = self.speed * delta
	if Input.is_action_pressed("player_left"):
		self.position.x -= velocity

	if Input.is_action_pressed("player_right"):
		self.position.x += velocity


func _input(event):
	if event.is_action_pressed("player_left") or event.is_action_pressed("player_right"):
		audio.play()

	if event.is_action_released("player_left") or event.is_action_released("player_right"):
		audio.stop()
