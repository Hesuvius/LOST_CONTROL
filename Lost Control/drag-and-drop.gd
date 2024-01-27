extends Sprite2D

var selected = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			selected = event.pressed
	elif event is InputEventMouseMotion:
		if selected:
			position = get_global_mouse_position()
