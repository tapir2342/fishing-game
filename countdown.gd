class_name Countdown
extends CanvasLayer


signal done


onready var _timer: Timer = $Timer

var _value_start := 60
var _value_current := _value_start


func _ready() -> void:
	_timer.connect("timeout", self, "_on_timer_tick")


func start() -> void:
	_timer.start()


func _on_timer_tick() -> void:
	_value_current -= 1
	$Label.text = str(_value_current)

	if _value_current == 0:
		_timer.disconnect("timeout", self, "_on_timer_tick")
		_timer.stop()
		self.emit_signal("done")
