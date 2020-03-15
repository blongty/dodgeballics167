extends Camera2D

var shake


# Called when the node enters the scene tree for the first time.
func _ready():
	shake = get_node("Shake");
	
func shake():
	shake.start()
