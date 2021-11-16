extends Control

var scene: Resource = Map.room[0]

func _unhandled_key_input(event):
	# If the key is a number or a letter or space
	if event.scancode > 47 and event.scancode < 91 or event.scancode == 32:
		get_tree().change_scene_to(scene)
