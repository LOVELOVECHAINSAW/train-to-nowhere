extends Area2D

var opened := false setget set_opened
var player: Node
export(PackedScene) var containing_item: PackedScene

## Sets the visuals accordingly
func set_opened(is_opened: bool) -> void:
	$BubbleSprite.set_visible(not is_opened)

	if is_opened:
		$ContainerSprite.frame = 1
	else:
		$ContainerSprite.frame = 0

	opened = is_opened

func _unhandled_key_input(event):
	if player and Input.is_action_just_pressed("ui_accept") and not opened:
		var item = containing_item.instance()
		get_parent().add_child(item)
		item.set_position(self.global_position)
		set_opened(true)

func _on_Container_body_entered(body):
	player = body


func _on_Container_body_exited(body):
	player = null
