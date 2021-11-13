extends Item

func _init():
	type = Item.TYPE.Pipe

func on_combine(item):
	var dialog = Dialogic.start("Unknown combination")
	if item == Item.TYPE.Key:
		dialog = Dialogic.start("Combine Pipe Key")
	return dialog
