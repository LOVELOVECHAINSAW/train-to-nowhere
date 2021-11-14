extends KinematicBody2D


const WALK_SPEED = 300

var velocity := Vector2.ZERO
var animation: String
var held_item: int

func _physics_process(_delta) -> void:
	set_velocity()
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
