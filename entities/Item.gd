extends Node

class_name Item

enum TYPE {
	Key,
	Pipe
}

onready var player = get_tree().current_scene.get_node("Player")
var previous_player_state
var mouse_hovering = false
var type

func _process(_delta):
	var distance = self.position.distance_to(player.global_position) 
	if distance < 150 and mouse_hovering:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

# Override this function
func on_combine(item_to_combine):
	pass

func on_dialog_end():
	player.state = previous_player_state
	pass

func on_click():
	if player.dropping_item:
		return

	if player.held_item != null:
		handle_combine()
		return

	player.on_item_clicked(self.type)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	var where = player.hovering_over.find(self)
	player.hovering_over.remove(where)
	queue_free()

func handle_combine():
	previous_player_state = player.state
	player.state = player.STATE.TALKING
	var dialog = on_combine(player.held_item)
	dialog.connect("dialog_end", self, "on_dialog_end")
	add_child(dialog)

func _on_Area2D_mouse_entered():
	mouse_hovering = true
	player.hovering_over.push_front(self)

func _on_Area2D_mouse_exited():
	mouse_hovering = false
	var where = player.hovering_over.find(self)
	player.hovering_over.remove(where)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Area2D_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if event is InputEventMouseButton:
		if self.global_position.distance_to(player.global_position) < 150 and event.is_pressed():
			on_click()
