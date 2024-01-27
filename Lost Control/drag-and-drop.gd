extends Sprite2D

var selected = false


func _on_area_2d_input_event(viewport, event, shape_idx):
	pass


func _input(event):
	if selected && event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			var relative_movement = event.relative
			position.x = position.x + relative_movement.x
			position.y = position.y + relative_movement.y


func _on_area_2d_body_entered(body):
	selected = true


func _on_area_2d_body_exited(body):
	selected = false
