extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0
var coins = 0
#var time_of_jump = 0

#func _process(delta: float) -> void:
	##var delta_time = 0
	##if not is_on_floor():
		##delta_time = Time.get_ticks_msec() - time_of_jump
	##elif time_of_jump != 0:
		##time_of_jump += delta*2
		##delta_time = Time.get_ticks_msec() - time_of_jump
	##$Camera2D.zoom = Vector2(1 + (delta_time**.8)*.002, 1 + (delta_time**.8)*.002)
	#if is_on_floor() and $Camera2D.zoom > Vector2(1, 1):
		#$Camera2D.zoom -= Vector2(delta*2, delta*2)
		#if $Camera2D.zoom < Vector2(1, 1):
			#$Camera2D.zoom = Vector2(1, 1)
	#elif not is_on_floor():
		#$Camera2D.zoom += Vector2(delta, delta)
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		#time_of_jump = Time.get_ticks_msec()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		if direction:
			$PlayerSprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func _on_coin_colision(body: Node2D) -> void:
	coins += 1
	$CoinCounter.text = "coins : %s" % coins


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	position = Vector2(0, - 1)
