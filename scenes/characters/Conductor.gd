extends "res://scenes/Character.gd"

func _get_dialog(item):
	var dialog =  Dialogic.start("Intro")
	if item == Item.TYPE.Key:
		dialog = Dialogic.start("Conductor Key")
	return dialog
