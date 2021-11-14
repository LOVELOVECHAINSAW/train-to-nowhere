extends Area2D

enum rooms {ROOM1, ROOM2, ROOM3}

export(rooms) onready var leads_to: int
export(bool) var locked: bool


func _on_Door_body_entered(_body) -> void:
	if locked:
		print("Locked")
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(Map.room[leads_to])
