extends CharacterBody2D

@onready var wall_colliding_ray_cast: RayCast2D = $WallCollidingRayCast
var direction: Vector2

var is_facing_wall: bool = false
var faced_wall = 0

@export var speed = 300.0
@export var jump_velocity = -400.0
@export var cayote_time_max = 10
@onready var cayote_time = cayote_time_max


func _process(delta: float) -> void:
	#$Label.text = str(get_meta("checkpoint_coordinates").x) + str(get_meta("checkpoint_coordinates").y)
	$Label.text =  str(faced_wall)
  
  
	if wall_colliding_ray_cast.is_colliding():
		print('face')
		is_facing_wall = true
		if direction.x == -1:
			faced_wall = -1
		else:
			faced_wall = 1
	else:
		is_facing_wall = false
		faced_wall = 0

	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		cayote_time -= 1 if cayote_time >0 else 0
	else:
		cayote_time = cayote_time_max

	# Handle jump.
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("jump") and is_on_floor():
		position.y += 1
	elif (Input.is_action_pressed("jump") and is_on_floor()) or (Input.is_action_just_pressed("jump") and cayote_time > 0):
		velocity.y = jump_velocity
		cayote_time = 0
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actaions.
	direction = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		if direction == Vector2.LEFT:
			direction = Vector2.ZERO
		else:
			direction = Vector2.RIGHT
		
	if direction:
		wall_colliding_ray_cast.target_position = direction * 32
		wall_colliding_ray_cast.force_raycast_update()
		
				
		
		velocity.x = direction.x * speed
		
		$PlayerSprite.flip_h = direction == Vector2.LEFT
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
