tool
extends Area2D

enum TYPE {SUITCASE = 0, LOCKER = 4, DRAWER = 8}
enum TIME_OF_DAY {DAY = 0, NIGHT = 2}
enum STATE {CLOSED, OPENED}

var player: Node

export(PackedScene) var containing_item: PackedScene
# Setgets to trigger _update_sprite().
# This function updates the sprite live, in the editor.
export(bool) var opened := false setget _set_opened
export(TYPE) var CONTAINER_TYPE := TYPE.SUITCASE setget _set_type
export(TIME_OF_DAY) var VARIANT := TIME_OF_DAY.DAY setget _set_variant

func _ready():
	print(1 + int(true))

func _update_sprite() -> void:
	$BubbleSprite.set_visible(not opened)
	$ContainerSprite.frame = CONTAINER_TYPE + VARIANT + int(opened)

func _unhandled_key_input(event):
	# Spawns the held item
	if player and Input.is_action_just_pressed("ui_accept")\
			and not opened and containing_item:
		var item = containing_item.instance()
		get_parent().add_child(item)
		item.set_position(self.global_position + Vector2.DOWN) # Spawns in player's hand
		_set_opened(true)

func _on_Container_body_entered(body):
	player = body

func _on_Container_body_exited(body):
	player = null

func _set_opened(is_opened: bool) -> void:
	opened = is_opened
	_update_sprite()

func _set_type(new_type: int) -> void:
	CONTAINER_TYPE = new_type
	_update_sprite()

func _set_variant(new_variant: int) -> void:
	VARIANT = new_variant
	_update_sprite()

