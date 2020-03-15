extends Node2D
var camera
func _ready():
	camera = get_node("Camera2D")
	
func shake(dur, freq, amp):
	camera.shake(dur, freq, amp)
