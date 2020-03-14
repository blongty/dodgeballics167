extends AnimatedSprite

var can_slap = true;
var timer
var slap_area

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	timer.set_one_shot(true)
	
	slap_area = $SlapArea

func slap(power, cooldown):
	if can_slap:
		frame = 0
		play()
		can_slap = false
		timer.set_wait_time(cooldown)
		timer.start()
		
		var balls = slap_area.get_overlapping_bodies()
		
		for ball in balls:
			var vect_dir = get_global_position().direction_to(ball.get_global_position())
			var dir = atan2(vect_dir.y, vect_dir.x)
			
			var speed = ball.get_linear_velocity().length()
			speed += power
			
			ball.set_linear_velocity(Vector2(speed * cos(dir), speed * sin(dir)))


func _on_Timer_timeout():
	can_slap = true
