class_name WinOrLose
extends CanvasLayer


func victory():
	$Panel.visible = true
	$Panel/Victory.visible = true
	$Panel/Victory/AudioStreamPlayer.play()
	$Panel/Defeat.visible = false


func defeat():
	$Panel.visible = true
	$Panel/Victory.visible = false
	$Panel/Defeat.visible = true
	$Panel/Defeat/AudioStreamPlayer.play()
