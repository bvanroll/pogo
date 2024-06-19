extends CharacterBody3D


const SPEED = 5.0
const AIRSPEED = 8.0
const MAXSPEED = 8.0
const JUMP_VELOCITY = 8.5
const BHOPDIFF = 8.0 #difficulty for bhops aka time before the rebounce height is reduced to 0
const BHOPHEIGHTDIV = 3. #divides the rebounce height, 1 for perfect rebounce
var max_neg_vel = 0.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	
	# Add the gravity.

	# Handle jump.

	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = jv

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	var direction = (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	var rotation = input_dir.x;
	if is_on_floor():
		var jv = JUMP_VELOCITY + (abs(velocity.y) *2.)
		if direction:
			if abs(velocity.x) < MAXSPEED:
				velocity.x += direction.x * SPEED *3. * delta
			if abs(velocity.z) < MAXSPEED:
				velocity.z += direction.z * SPEED *3. * delta
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump"):
			velocity.y += jv + abs(max_neg_vel/BHOPHEIGHTDIV)
		
		max_neg_vel = move_toward(max_neg_vel, 0, SPEED * (delta*BHOPDIFF))
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * delta)
	
	else:
		velocity.y -= gravity * delta
		if velocity.y < max_neg_vel:
			max_neg_vel = velocity.y
		if direction:
			velocity.x += direction.x * AIRSPEED *3. * delta
			velocity.z += direction.z * AIRSPEED *3. * delta
			rotate_y(input_dir.x)
		velocity.x = move_toward(velocity.x, 0, SPEED * (delta/2.))
		velocity.z = move_toward(velocity.z, 0, SPEED * (delta/2.))
		log(1.)

	move_and_slide()
