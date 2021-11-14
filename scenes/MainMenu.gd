extends MarginContainer

var scene: Resource = preload("res://scenes/levels/Level1.tscn")

func _on_Button_pressed():
	get_tree().change_scene_to(scene)
