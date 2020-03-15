extends KinematicBody2D

#var sound1 = AudioStreamPlayer.new()
#var speed = 0
#var timer = 0
##var in_range = 0
#var cool_down = 0
#var temp  = 0;
var motion = Vector2()
#export var max_snowballcount = 3
#export var init_snowballcount = 3
#var snowballcount
#export (PackedScene) var bullet
#export (PackedScene) var aim
export (PackedScene) var snowp
export (PackedScene) var particle1
export (int) var player_id
#export (float, 0, 1, .01) var axis_deadzone
#onready var firepoint = get_node("firepoint")

var canInteract = false
var interactables = []
#var hasSnow = false
#var full_ammo
var last_motion = Vector2(200, 0)
export (int) var move_speed = 400
export (float, 0, 1, 0.05) var joy_deadzone = 0.2
var aiming = false

var blocker
var blocker_sprite

func _ready():
	blocker = get_node("Block/CollisionShape2D")
	blocker_sprite = get_node("Block/Sprite")
	blocker_disable()
	#add_child(aim.instance())
	#self.add_child(sound1)
	#sound1.stream = load("res://catched.mp3")
	#sound1.play()
	#snowballcount = init_snowballcount
	
	#if snowballcount >= max_snowballcount:
		#full_ammo = true
	#else:
		#full_ammo = false

func _physics_process(delta):
	move_and_slide(motion);

func _process(delta):
	#in_range -= 1
	#cool_down -= 1
	#temp -= 1
	#var bb;
	
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
	
	# Draws trajectory of snowballs when SHOOT* is held down
	#if snowballcount > 0:
	#blocking
	if Input.is_joy_button_pressed(player_id, JOY_BUTTON_5):
		blocker_enable()
		motion.y = 0
		motion.x = 0
	else:
		blocker_disable()
	#		if Input.is_action_pressed("SHOOT") or Input.is_action_pressed("SHOOT_BY_MOUSE"):
	#			draw_trajectory()
	
func blocker_enable():
	blocker_sprite.visible = true
	blocker.disabled = false
	
func blocker_disable():
	blocker_sprite.visible = false
	blocker.disabled = true
	# Placeholder
	#if (Input.is_action_just_pressed("CATCH") and in_range > 0 and cool_down <= 0):
	#	in_range = 0
	#	snowballcount += 1
	#	sound1.play()
	#	pass
	
	#if (Input.is_action_just_released("SHOOT_BY_MOUSE") and Input.is_action_just_released("SHOOT")):
	#	print(Input.is_action_just_released("SHOOT_BY_MOUSE"))
	
	# Interacting with object
	#if Input.is_action_just_pressed("INTERACT"):
	#	if canInteract:
	#		get_closest_interactable().interact()
			#print_debug(snowballcount)
	#	else:
	#		if hasSnow == true and interactables.empty() == true :
	#			var sn
	#			sn = snowp.instance()
	#			sn.position = position
	#			get_tree().get_root().get_node("Node2D").add_child(sn)
	#			sn.get_node("CollisionShape2D").free()
	#			hasSnow = false
				
				
				
				
				

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

#func get_snowballcount():
	#return snowballcount
	
#func get_max_snowballcount():
	#return max_snowballcount

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


func _on_Field_ready():
	pass # Replace with function body.


func _on_snowball_enter(area : Area2D):
	if area.collision_layer == 2:
		if area.parent.state == 0:
			pass
		else:
			var death_p = get_node("Particles2D")
			death_p.death()
			var parent = get_parent();
			parent.shake();
			queue_free();
