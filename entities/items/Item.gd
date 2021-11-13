extends Node

class_name Item

enum TYPE {
	KEY
}

onready var player = get_tree().current_scene.get_node("Player")
var mouse_hovering = false

# func _ready():
# 	player = get_tree().current_scene.get_node("Player")

func _process(_delta):
	if (mouse_hovering):
		on_hover()
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func on_hover():
	var player_position = player.global_transform.origin

	if self.position.distance_to(player_position) < 150:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

		if Input.is_action_pressed("ui_mouse_click"):
			on_click()
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func on_click():
	player.on_item_clicked(self)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	queue_free()

func _on_Area2D_mouse_entered():
	mouse_hovering = true

func _on_Area2D_mouse_exited():
	mouse_hovering = false
