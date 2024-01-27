extends CharacterBody2D

@onready var collision_polygon = $CollisionPolygon2D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func clamp_position():
	var viewport_rect = get_viewport_rect()
	var bottom_right = viewport_rect.end

	var polygon_measurements = calculate_polygon_measurements(collision_polygon.polygon)

	var min_x = (polygon_measurements[0].x * -1) * collision_polygon.scale.x
	var min_y = (polygon_measurements[0].y * -1) * collision_polygon.scale.y
	var max_x = bottom_right.x - (polygon_measurements[1].x * collision_polygon.scale.x)
	var max_y = bottom_right.y - (polygon_measurements[1].y * collision_polygon.scale.y)

	var current_pos = position

	position.x = clamp(current_pos.x, min_x, max_x)
	position.y = clamp(current_pos.y, min_y, max_y)


func calculate_polygon_measurements(polygon_points):
	var x_coords = []
	var y_coords = []
	for point in polygon_points:
		x_coords.append(point.x)
		y_coords.append(point.y)

	var min_x = INF
	var max_x = -INF
	var min_y = INF
	var max_y = -INF

	for x in x_coords:
		if x < min_x:
			min_x = x
		if x > max_x:
			max_x = x

	for y in y_coords:
		if y < min_y:
			min_y = y
		if y > max_y:
			max_y = y

	return [Vector2(min_x, min_y), Vector2(max_x, max_y)]


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			var relative_movement = event.relative
			position.x = position.x + relative_movement.x
			position.y = position.y + relative_movement.y
			clamp_position()
	pass
