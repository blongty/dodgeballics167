extends RigidBody2D
export(float) var state_one_speed=20
export(float) var state_two_speed=50
export(float) var dead_ball_damp=50
export(float) var normal_ball_damp=-1
var direction : Vector2
var state : int

func _ready():
	pass

# Once added to the scene tree, function will immediately start moving
func _physics_process(delta):
	var velocity = get_linear_velocity()
	var speed = velocity.length()
	#apply_impulse(Vector2(), direction.normalized() * speed)
	
	#The ball is in the normal state, can be blocked
	if (speed >= state_one_speed  and speed <= state_two_speed):
		state = 1;
		$Sprite.set_modulate(Color(0,1,0))
		print("ball state is one")
	#The ball is in the high speed, can not be blocked
	elif (speed > state_two_speed):
		state = 2;
		$Sprite.set_modulate(Color(1, 0, 0))
		print("ball state is two")
	#The ball is dead.
	else:
		state = 0;
		$Sprite.set_modulate(Color(1,1,1))
		set_angular_damp(dead_ball_damp)
		set_linear_damp(dead_ball_damp)
	
#	print(speed)
		
# Call this function before adding the instance to the tree
# Given a point, will launch snowball towards that point
func set_direction_absolute(target : Vector2, radius : float = -100):
	if (radius == -100):
		direction = target - get_transform().get_origin()
		direction = direction.normalized()

func set_direction_offset(offset: Vector2, radius: float = -100):
	direction = offset
	direction = direction.normalized()
