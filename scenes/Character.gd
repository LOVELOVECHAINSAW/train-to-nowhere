extends Node

class_name Character

onready var player = get_tree().current_scene.get_node("Player")

var previous_player_state
var mouse_hovering = false

# Override in child class
func _get_dialog(item):
	pass

func on_dialog_end(event):
	player.state = self.previous_player_state

func _process(delta):
	var distance = self.position.distance_to(player.global_position) 
	if distance < 150 and mouse_hovering:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if player.state == player.STATE.TALKING:
		return

	if event is InputEventMouseButton:
		if self.global_position.distance_to(player.global_position) < 150 and event.is_pressed():
			var dialog = self._get_dialog(player.held_item)
			dialog.connect("timeline_end", self, "on_dialog_end")
			previous_player_state = player.state
			player.state = player.STATE.TALKING
			add_child(dialog)

func _on_mouse_entered():
	mouse_hovering = true
	player.hovering_over.push_front(self)

func _on_mouse_exited():
	mouse_hovering = false
	var where = player.hovering_over.find(self)
	player.hovering_over.remove(where)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
