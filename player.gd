extends CharacterBody2D

const SPEED = 300.0
const DECELERATION_VELOCITY = 50
const JUMP_VELOCITY = -600

var gravity = ProjectSettings.get("physics/2d/default_gravity")

@onready var toggle_button: CheckButton = %CheckButton


func _ready():
	toggle_button.set_pressed_no_signal(slide_on_ceiling)


func _physics_process(delta):
	# Simulate weightlessnes.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")

	if is_on_floor():
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, DECELERATION_VELOCITY)

	move_and_slide()


func _on_check_button_toggled(button_pressed: bool):
	print("setting slide_on_ceiling to %s" % button_pressed)
	slide_on_ceiling = button_pressed
