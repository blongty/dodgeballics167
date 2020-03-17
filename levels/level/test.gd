extends Node2D
var camera
onready var ball1 = get_node("Snowball")
onready var ball2 = get_node("Snowball2")
onready var ball3 = get_node("Snowball3")
onready var ball4 = get_node("Snowball4")
onready var ball5 = get_node("Snowball5")
onready var ball6 = get_node("Snowball6")
onready var player1 = get_node("Player")
onready var player2 = get_node("Player2")
onready var b1 = ball1.position
onready var b2 = ball2.position
onready var b3 = ball3.position
onready var b4 = ball4.position
onready var b5 = ball5.position
onready var b6 = ball6.position
onready var p1 = player1.position
onready var p2 = player2.position
var s1 = 0
var s2 = 0
var scoreA
var scoreB
func _ready():
	scoreA = $UI/MarginContainer/VBoxContainer/HBoxContainer/Left
	scoreB = $UI/MarginContainer/VBoxContainer/HBoxContainer/Right
	camera = get_node("Camera2D")
	
func shake(dur, freq, amp):
	camera.shake(dur, freq, amp)

func restart():
#	ball1.position = b1
#	ball2.position = b2
#	ball3.position = b3
#	ball4.position = b4
#	ball5.position = b5
#	ball6.position = b6
#	player1.position = p1
#	player2.position = p2
	get_tree().change_scene(get_filename())
	
func aplus():
	s1 += 1
	scoreA.text = str(s1);
	#var ui = get_node("UI").get_child(1).get_child(1).get_child(1).get_child(1)
	
func bplus():
	s2 += 1
	scoreB.text = str(s2);
