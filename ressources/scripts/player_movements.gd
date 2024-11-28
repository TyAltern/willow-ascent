extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0

func _process(delta: float) -> void:
	$Label.text = str(get_meta("checkpoint_coordinates").x) + str(get_meta("checkpoint_coordinates").y)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("move_down") and Input.is_action_just_pressed("jump") and is_on_floor():
		position.y += 1
	elif Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actaions.
	var direction
	if Input.is_action_pressed("move_left"):
		direction = -1
	if Input.is_action_pressed("move_right"):
		if direction == -1:
			direction = 0
		else:
			direction = 1
		
	if direction:
		velocity.x = direction * speed
		$PlayerSprite.flip_h = direction < 0
		if is_on_floor():
			$PlayerSprite.play("walking")
			$PlayerSprite.speed_scale = 1
		else:
			$PlayerSprite.speed_scale = 0.2
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		$PlayerSprite.play("idle")

	move_and_slide()

func kill():
	position = get_meta("checkpoint_coordinates")
