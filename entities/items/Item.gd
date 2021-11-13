extends Node

class_name Item

enum TYPE {
	KEY
}

onready var player = get_tree().current_scene.get_node("Player")
var type = TYPE.KEY
var mouse_hovering = false

func _process(_delta):
	var distance = self.position.distance_to(player.global_position) 
	if distance < 150 and mouse_hovering:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func on_click():
	if (player.dropping_item):
		return
	player.on_item_clicked(self.type)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	queue_free()

func _on_Area2D_mouse_entered():
	mouse_hovering = true

func _on_Area2D_mouse_exited():
	mouse_hovering = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Area2D_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if event is InputEventMouseButton:
		if self.global_position.distance_to(player.global_position) < 150 and event.is_pressed():
			on_click()
