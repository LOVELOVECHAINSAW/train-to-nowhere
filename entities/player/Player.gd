extends KinematicBody2D

enum FACING {
	UP, DOWN, LEFT, RIGHT
}

enum STATE {
	SITTING,
	STANDING,
	TALKING
	IDLE
}

const WALK_SPEED = 300

var facing = FACING.UP
var state = STATE.SITTING
var velocity = Vector2.ZERO
var animation = ""
var held_item
var dropping_item = false
var hovering_over = []

func on_item_clicked(item):
	held_item = item
	$Item.visible = true

func _input(event):
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

func _drop_item(position):
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

func _process(delta):
	$DebugText.text = STATE.keys()[state]

func _on_animation_finished(anim_name:String):
	if anim_name == "standing_up":
		self.state = STATE.IDLE

func _physics_process(delta):
	if (
		self.state == STATE.STANDING or
		self.state == STATE.TALKING
	):
		return

	var speed = Vector2.ZERO

	if Input.is_action_pressed("ui_down"):
		speed += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		speed += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		speed += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		speed += Vector2.UP

	if speed.length() > 0 and self.state == STATE.SITTING:
		$AnimationPlayer.play("standing_up")
		self.state = STATE.STANDING
		return

	var new_animation = (
		"walk_right" if speed.x > 0 else
		"walk_left"  if speed.x < 0 else
		"walk_down"  if speed.y > 0 else
		"walk_up"    if speed.y < 0 else
		""
	)

	speed *= WALK_SPEED
	velocity = speed

	move_and_slide(velocity)

	if $AnimationPlayer.current_animation != new_animation:
		$AnimationPlayer.play(new_animation)
