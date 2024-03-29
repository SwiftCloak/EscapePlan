extends "pawn.gd"

onready var Grid = get_parent()

func _ready():
	update_look_direction(Vector2(1, 0))


func _process(_delta):
	if(variable.turn == 1):
		var input_direction = get_input_direction()
		if not input_direction:
			return
		update_look_direction(input_direction)

		var target_position = Grid.request_move(self, input_direction)
		if target_position:
			move_to(target_position)
		else:
			bump()
	else:
		pass

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("KEY_D")) - int(Input.is_action_pressed("KEY_A")),
		int(Input.is_action_pressed("KEY_S")) - int(Input.is_action_pressed("KEY_W"))
	)


func update_look_direction(direction):
	$Node2D/Sprite.rotation = direction.angle()
	
	
func move_to(target_position):
	set_process(false)
	$AnimationPlayer.play("walk")

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	$Tween.interpolate_property($Node2D, "position", - move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	position = target_position

	$Tween.start()

	# Stop the function execution until the animation finished
	yield($AnimationPlayer, "animation_finished")
	variable.turn -=1
	set_process(true)


func bump():
	set_process(false)
	$AnimationPlayer.play("bump")
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
