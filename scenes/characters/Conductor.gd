extends "res://scenes/characters/Character.gd"

func _get_dialog(item):
	var dialog
	if item == null:
		dialog = Dialogic.start("Intro")
	elif item == Item.TYPE.KEY:
		dialog = Dialogic.start("Conductor Key")
	return dialog
