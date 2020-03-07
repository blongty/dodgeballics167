extends RigidBody2D

var direction : Vector2
#var life = 1
var vel_1 = Vector2(50, 50)

var vel_2 = Vector2(100, 100)
#export(float) var speed = 1000
#var pid_owner

# Once added to the scene tree, function will immediately start moving
func _ready():
	set_linear_velocity(Vector2(50,50))
	#apply_impulse(Vector2(), direction.normalized() * speed)
	if (vel_2>=get_linear_velocity() >= vel_1):
		$Sprite.set_modulate(Color(0,1,0))
		print("ball state is one")
	elif (get_linear_velocity() > vel_2):
		$Sprite.set_modulate(Color(1, 0, 0))
		print("ball state is two")
	else:
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

#func _input(event):
#	if event is InputEventKey and event.scancode == KEY_SPACE:
#		if event.is_pressed() and not event.is_echo():
#			print('fire')
#			set_direction(get_transform().get_origin() + Vector2(200,0))
#			print(direction)
#			apply_impulse(Vector2(), direction.normalized() * speed)
			

#func _on_other_area_entered(other : Area2D):
	#if other.collision_layer == 1:
	#	if other.get_parent().get_player_id() == get_pid_owner():
	#		return
	#life -= 1
	#if (life <= 0):
	#	queue_free()

#func _on_other_body_entered(other : Node):
#	if other.collision_layer == 1:
#		if other.get_player_id() == get_pid_owner():
#			return
#	life -= 1
#	print(life)
#	if (life <= 0):
#		queue_free()

#func get_pid_owner():
	#return pid_owner
