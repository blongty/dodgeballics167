extends KinematicBody2D


export(int) var player_id
export(int) var move_speed = 400
export(float, 0, 1, 0.05) var joy_deadzone = 0.2
export(float) var slap_power = 1000
export(float) var slap_cooldown = 0.5

var motion = Vector2()
var canInteract = false
var interactables = []
var last_motion = Vector2(200, 0)
var blocker
var blocker_sprite
var slap_controller
var blocking = false
var slapping = false
var slap_button_down;

func _ready():
	blocker = get_node("Block/CollisionShape2D")
	blocker_sprite = get_node("Block/Sprite")
	blocker_disable()
	slap_controller = get_node("Slap")
	slap_button_down = Input.is_joy_button_pressed(player_id, JOY_L2)

func _physics_process(delta):
	move_and_slide(motion);

func _process(delta):
	# Movement
	# 	Moving requires joystick input beyond deadzone. Due to InputMap limitations, unable to
	# 	get deadzohne, so manually adjust it in edior when changed in InputMap. Also handles keys.
	motion.x = 0
	motion.y = 0
	
	if moving_at_all():
		if abs(Input.get_joy_axis(player_id, JOY_AXIS_1)) > joy_deadzone or \
			abs(Input.get_joy_axis(player_id, JOY_AXIS_0)) > joy_deadzone:
			motion.y += move_speed * Input.get_joy_axis(player_id, JOY_AXIS_1)
			motion.x += move_speed * Input.get_joy_axis(player_id, JOY_AXIS_0)
#		else:
#			if Input.is_action_pressed("MOVE_UP"):
#				motion.y -= move_speed
#			if Input.is_action_pressed("MOVE_DOWN"):
#				motion.y += move_speed
#			if Input.is_action_pressed("MOVE_LEFT"):
#				motion.x -= move_speed
#			if Input.is_action_pressed("MOVE_RIGHT"):
#				motion.x += move_speed			
	
	# Rotation
	if motion != Vector2(0,0):
		set_rotation(atan2(Input.get_joy_axis(player_id, JOY_AXIS_1), Input.get_joy_axis(player_id, JOY_AXIS_0)))
	
	# Blocking
	if Input.is_joy_button_pressed(player_id, JOY_L2) and not slapping:
		blocker_enable()
		motion.y = 0
		motion.x = 0
	else:
		blocker_disable()
	
	# Slapping
	if Input.is_joy_button_pressed(player_id, JOY_R2) and not blocking and not slap_button_down:
		slap_button_down = true
		slap()
	elif not Input.is_joy_button_pressed(player_id, JOY_R2) and slap_button_down:
		slap_button_down = false
		

func slap():
	slapping = true
	slap_controller.slap(slap_power, slap_cooldown)

func blocker_enable():
	blocking = true
	blocker_sprite.visible = true
	blocker.disabled = false
	
func blocker_disable():
	blocking = false
	blocker_sprite.visible = false
	blocker.disabled = true
	# Placeholder
	
func get_closest_interactable():
	var closest_obj
	var closest_obj_dist = 9999
	
	for i in interactables:
		if get_global_transform().get_origin().distance_to(i.get_global_transform().get_origin()) < closest_obj_dist:
			closest_obj = i
			closest_obj_dist = get_global_transform().origin.distance_to(i.get_global_transform().get_origin())
	
	return closest_obj

func get_player_id():
	return player_id
	
func get_player_id_str():
	return str(player_id)

func using_r_stick():
	# Though inaccurate, this function actually checks to see if satisfies
	# deadzone of right joystick inputs. "Works".
	return Input.is_action_pressed("AIM_UP") or \
		  Input.is_action_pressed("AIM_DOWN") or \
		  Input.is_action_pressed("AIM_LEFT") or \
		  Input.is_action_pressed("AIM_RIGHT")	

func moving_at_all():
	return Input.is_action_pressed("MOVE_UP") or \
		Input.is_action_pressed("MOVE_DOWN") or \
		Input.is_action_pressed("MOVE_LEFT") or \
		Input.is_action_pressed("MOVE_RIGHT")


func _on_Slap_animation_finished():
	slapping = false
