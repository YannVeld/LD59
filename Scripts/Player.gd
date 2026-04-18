extends CharacterBody2D

const SPEED = 50.0
var direction = 'right' 

func _physics_process(delta: float) -> void:


	# Handle jump.
	if Input.is_action_just_pressed("move_down"):
		direction = 'down' 
	if Input.is_action_just_pressed("move_up"):
		direction = 'up' 
	if Input.is_action_just_pressed("move_left"):
		direction = 'left' 
	if Input.is_action_just_pressed("move_right"):
		direction = 'right' 

	# Get the input direction and handle the movement/deceleration.
	if direction == 'up':
		velocity.y = -SPEED
		velocity.x = 0
	if direction == 'down':
		velocity.y = SPEED
		velocity.x = 0
	if direction == 'right':
		velocity.x = SPEED
		velocity.y = 0
	if direction == 'left':
		velocity.x = -SPEED
		velocity.y=0

	move_and_slide()
