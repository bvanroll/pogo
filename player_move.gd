extends CharacterBody3D


const SPEED = 5.0
const AIRSPEED = 8.0
const MAXSPEED = 8.0
const JUMP_VELOCITY = 3.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	
	# Add the gravity.

	# Handle jump.
	var jv = JUMP_VELOCITY + abs(velocity.y)
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = jv

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if is_on_floor():
		if direction:
			if abs(velocity.x) < MAXSPEED:
				velocity.x += direction.x * SPEED *3. * delta
			if abs(velocity.z) < MAXSPEED:
				velocity.z += direction.z * SPEED *3. * delta
		if Input.is_action_pressed("ui_accept"):
			velocity.y += jv
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * delta)
	
	else:
		velocity.y -= gravity * delta
		if direction:
			velocity.x += direction.x * AIRSPEED *3. * delta
			velocity.z += direction.z * AIRSPEED *3. * delta
		velocity.x = move_toward(velocity.x, 0, SPEED * (delta/2.))
		velocity.z = move_toward(velocity.z, 0, SPEED * (delta/2.))
		log(1.)

	move_and_slide()
