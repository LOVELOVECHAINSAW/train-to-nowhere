extends Control

var scene: Resource = Map.room[0]

func _unhandled_key_input(event):
	if event.scancode > 47 and event.scancode < 91 or event.scancode == 32: # If the key is a number or a letter
		get_tree().change_scene_to(scene)
