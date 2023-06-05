extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta):
	# Simulate weightlessnes.
	if not is_on_floor():
		velocity.y += -100 * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_check_button_toggled(button_pressed:bool):
	slide_on_ceiling = button_pressed
