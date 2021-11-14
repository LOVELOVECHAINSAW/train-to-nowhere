extends KinematicBody2D

const WALK_SPEED = 300

onready var held_position: Vector2 = $HeldPosition.position

var velocity := Vector2.ZERO
var animation: String
var item: Node setget set_item

func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("ui_accept") and item:
		_drop_item()

func _drop_item() -> void:
	$HeldItems.remove_child(item)
	get_parent().call_deferred("add_child", item)

# warning-ignore:return_value_discarded
	item.connect("body_exited", item, "_on_Item_body_exited")
	item.global_position = self.global_position
	item = null

func _physics_process(_delta) -> void:
	set_velocity()
# warning-ignore:return_value_discarded
	move_and_slide(velocity)

	set_animation()

	if $AnimationPlayer.current_animation != animation:
		$AnimationPlayer.play(animation)

func set_velocity() -> void:
	velocity.x = Input.get_action_strength("ui_right") -\
			Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") -\
			Input.get_action_strength("ui_up")

	velocity = velocity.normalized() * WALK_SPEED

func set_animation() -> void:
	match velocity:
		Vector2.UP:
			animation = "walk_up"
		Vector2.DOWN:
			animation = "walk_down"
		Vector2.LEFT:
			animation = "walk_left"
		Vector2.RIGHT:
			animation = "walk_right"
		_:
			animation = "" # We can give a proper animation name later

func set_item(new_item: Node) -> void:
	item = new_item

	for held_item in $HeldItems.get_children():
		held_item.queue_free()

	# Deferred because adding and removing children can't be done while
	# flushing queries
	$HeldItems.call_deferred("add_child", item)
	item.call_deferred("set_position", held_position)
