extends KinematicBody2D

const WALK_SPEED = 50

onready var held_position: Vector2 = $HeldPosition.position

var velocity := Vector2.ZERO
var animation: String = "idle"
var item: Node setget set_item

func _unhandled_key_input(_event) -> void:
	if Input.is_action_just_pressed("ui_accept") and item:
		_drop_item()

func _drop_item() -> void:
	# Bug, possible to call function _drop_item while the item is orphan,
	# because of call_deferred.
	$HeldItems.remove_child(item)
	get_parent().call_deferred("add_child", item)

# warning-ignore:return_value_discarded
	item.connect("body_exited", item, "_on_Item_body_exited")
	item.global_position = self.global_position
	item = null
	
	$Drop.play()

func _physics_process(_delta) -> void:
	set_velocity()
# warning-ignore:return_value_discarded
	move_and_slide(velocity.normalized() * WALK_SPEED)

	set_animation()

	$AnimationPlayer.play(animation)

func set_velocity() -> void:
	velocity.x = Input.get_action_strength("ui_right") -\
			Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") -\
			Input.get_action_strength("ui_up")

func set_animation() -> void:
	match velocity:
		Vector2.LEFT:
			$Sprite.flip_h = true
		Vector2.RIGHT:
			$Sprite.flip_h = false
	
	if velocity != Vector2.ZERO:
		animation = "walk"
	else:
		animation = "idle"
	
	if item:
		match animation:
			"walk":
				animation = "walk_hold"
			"idle":
				animation = "idle_hold"

func set_item(new_item: Node) -> void:
	if item:
		_drop_item()

	item = new_item

	# Deferred because adding and removing children can't be done while
	# flushing queries
	$HeldItems.call_deferred("add_child", item)
	item.call_deferred("set_position", held_position)

	$Pickup.play()
