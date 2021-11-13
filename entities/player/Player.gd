extends KinematicBody2D

enum FACING {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

enum STATE {
	SITTING,
	STANDING,
	TALKING,
	IDLE
}

const WALK_SPEED = 300

var facing: int = FACING.UP
var state: int = STATE.SITTING
var velocity := Vector2.ZERO
var animation: String
var held_item
var dropping_item := false
var hovering_over: Array = []

func on_item_clicked(item) -> void:
	held_item = item
	$Item.visible = true

func _input(event) -> void:
	if event is InputEventMouseButton and event.pressed:
		if held_item == null:
			return
		var mouse_position = get_global_mouse_position()
		if self.global_position.distance_to(mouse_position) > 150:
			return

		if state == STATE.TALKING:
			return
		for value in hovering_over:
			if value is Character or value is Item:
				return

		_drop_item(mouse_position)

func _drop_item(position) -> void:
	dropping_item = true
	var item_name = Item.TYPE.keys()[held_item]
	var item_instance = load("res://entities/items/" + item_name + ".tscn").instance()
	item_instance.type = held_item
	item_instance.global_position = position
	get_tree().current_scene.add_child(item_instance)
	held_item = null
	$Item.visible = false

	yield(get_tree().create_timer(0.1), "timeout")
	dropping_item = false

func _process(_delta) -> void:
	$DebugText.text = STATE.keys()[state]

func _physics_process(_delta) -> void:
	if (
		self.state == STATE.STANDING or
		self.state == STATE.TALKING
	):
		return

	set_velocity()
	move_and_slide(velocity)

	set_animation()
	# To be fixed later
	if velocity != Vector2.ZERO and self.state == STATE.SITTING:
		$AnimationPlayer.play("standing_up")
		self.state = STATE.STANDING
		return

	if $AnimationPlayer.current_animation != animation:
		$AnimationPlayer.play(animation)

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "standing_up": # What ?
		self.state = STATE.IDLE

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
