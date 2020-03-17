extends Control

func _on_TextureButton_button_down():
	var parent = get_parent();
	parent.restart();

func changeScore(a, b):
	pass;
