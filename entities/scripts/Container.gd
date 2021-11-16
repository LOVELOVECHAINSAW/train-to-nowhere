extends Area2D

enum CONTAINER_TYPE {SUITCASE = 0, LOCKED_DRAWER = 2, DRAWER = 4}

var opened := false setget set_opened
var player: Node
export(CONTAINER_TYPE) var type: int
export(PackedScene) var containing_item: PackedScene

func _ready():
	$ContainerSprite.frame = type

## Sets the visuals accordingly
func set_opened(is_opened: bool) -> void:
	$BubbleSprite.set_visible(not is_opened)

	if is_opened:
		$ContainerSprite.frame = type + 1
	else:
		$ContainerSprite.frame = type

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
