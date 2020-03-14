extends Node
const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT
var amp=20
var fre=20
var dur=20
onready var camera = get_parent()
func start(duration=0.5, frequency=20, amplitude=20):
	amp=amplitude
	$dur.wait_time=duration
	$fre.wait_time=1/float(frequency)
	$dur.start()
	$fre.start()
	shake()

func shake():
	var rand = Vector2()
	rand.x = rand_range(-amp, amp)
	rand.y = rand_range(-amp, amp)
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $fre.wait_time, TRANS, EASE)
	$ShakeTween.start()
	pass

func _on_fre_timeout():
	shake()

func _on_dur_timeout():
	reset()
	$fre.stop()
	
func reset():
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, Vector2(), $fre.wait_time, TRANS, EASE)
	$ShakeTween.start()
func _on_Field_ready():
	start();
