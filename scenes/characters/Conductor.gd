extends "res://scenes/characters/Character.gd"

func _get_dialog():
	var dialog = Dialogic.start("Intro")
	return dialog
