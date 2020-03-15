extends Node2D
var camera
func _ready():
	camera = get_node("Camera2D")
	camera.shake()
	
func shake():
	camera.shake()
