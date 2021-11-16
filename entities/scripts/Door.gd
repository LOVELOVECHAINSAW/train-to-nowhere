tool
extends Area2D

enum rooms {ROOM1, ROOM2, ROOM3}
enum TIME_OF_DAY {DAY = 0, NIGHT = 2}

export(rooms) var leads_to: int # Refers to the room array in Map singleton
export(bool) var requires_key: bool = false

# Setgets to trigger _update_sprite().
# This function updates the sprite live, in the editor.
export(bool) var locked: bool setget _set_locked
export(TIME_OF_DAY) var VARIANT setget _set_variant

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

func _update_sprite():
	if not locked:
		$OpenSound.play()

	$Door.frame = VARIANT + int(locked)

## locked setter.
## Used to updated sprite in the editor
func _set_locked(is_locked: bool) -> void:
	locked = is_locked
	# Call deferred because _set_locked gets called before ready
	call_deferred("_update_sprite")

## variant setter.
## Used to updated sprite in the editor.
func _set_variant(new_variant: int) -> void:
	VARIANT = new_variant
	# Call deferred because _set_locked gets called before ready
	call_deferred("_update_sprite")
