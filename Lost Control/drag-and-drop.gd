extends Sprite2D

var touching = false
var selected = false


func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if selected && event is InputEventMouseMotion:
			var relative_movement = event.relative
			position.x = position.x + relative_movement.x
			position.y = position.y + relative_movement.y
		if touching && event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				selected = event.pressed


func _on_area_2d_body_entered(_body):
	touching = true


func _on_area_2d_body_exited(_body):
	touching = false
	selected = false
