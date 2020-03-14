extends RigidBody2D
export(float) var state_one_speed
export(float) var state_two_speed
var direction : Vector2
var state : int
#var life = 1
#export(float) var speed = 1000
#var pid_owner


# Once added to the scene tree, function will immediately start moving
func _ready():
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
		
# Call this function before adding the instance to the tree
# Given a point, will launch snowball towards that point
func set_direction_absolute(target : Vector2, radius : float = -100):
	if (radius == -100):
		direction = target - get_transform().get_origin()
		direction = direction.normalized()

func set_direction_offset(offset: Vector2, radius: float = -100):
	direction = offset
	direction = direction.normalized()
