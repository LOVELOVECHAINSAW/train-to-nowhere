extends Node

onready var player = get_tree().current_scene.get_node("Player")

var previous_player_state

func _get_dialog():
	pass

func on_dialog_end(event):
	player.state = self.previous_player_state

func _on_Area2D_input_event(viewport, event, shape_idx):
	if player.state == player.STATE.TALKING:
		return

	if event is InputEventMouseButton:
		if self.global_position.distance_to(player.global_position) < 150 and event.is_pressed():
			var dialog = self._get_dialog()
			dialog.connect("timeline_end", self, "on_dialog_end")
			previous_player_state = player.state
			player.state = player.STATE.TALKING
			add_child(dialog)
