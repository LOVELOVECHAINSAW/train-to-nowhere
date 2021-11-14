extends MarginContainer

var scene: Resource = preload("res://scenes/levels/Level1.tscn")

func _on_Button_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(scene)
