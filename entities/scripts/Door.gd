extends Area2D

enum rooms {ROOM1, ROOM2, ROOM3}

export(rooms) onready var leads_to: int
export(bool) var locked: bool setget _set_locked
export(bool) var requires_key: bool = false

func _on_Door_body_entered(player) -> void:
	if locked:
		$LockedSound.play()
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(Map.room[leads_to])

	if requires_key and player.item and locked:
		if player.item.id == "key":
			$OpenSound.play()

			player.set_processes(false)

			yield($OpenSound, "finished")

# warning-ignore:return_value_discarded
			get_tree().change_scene_to(Map.room[leads_to])

func _set_locked(is_locked: bool) -> void:
	if not is_locked:
		$OpenSound.play()
		$Sprite.frame = 1
	else:
		$Sprite.frame = 0

	locked = is_locked
