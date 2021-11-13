extends Item

func _init():
    type = Item.TYPE.Key

func on_combine(item):
	var dialog = Dialogic.start("Unknown combination")
	if item == Item.TYPE.Pipe:
		dialog = Dialogic.start("Combine Pipe Key")
	return dialog
	