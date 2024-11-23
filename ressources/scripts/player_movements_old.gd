extends CharacterBody2D

var screen_size
@export var speed = 400
@export var jump_strength = 1
@export var downward_force = .05
@export var god_mode = false
#var is_grounded = false
var is_jumping = false
var vertical_velocity = 0

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if god_mode:
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
	else:
		if Input.is_action_pressed("move_up"):
			if !is_jumping:
				is_jumping = true
				vertical_velocity = 0-jump_strength
		if is_jumping:
			if is_on_floor():
				vertical_velocity += downward_force
			else:
				is_jumping = false
				vertical_velocity = 0
			velocity.y = vertical_velocity
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "climb"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
