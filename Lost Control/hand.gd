extends CharacterBody2D

@onready var collision_shape = $CollisionShape2D
@onready var arm = $Arm


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func update_position(relative_movement):
	var viewport_rect = get_viewport_rect()
	var bottom_right = viewport_rect.end

	var radius = collision_shape.shape.radius
	var scale = collision_shape.scale.x
	
	var min = (radius * scale) / 2
	var max_x = bottom_right.x - (radius * scale)
	var max_y = bottom_right.y - (radius * scale)

	var old_x = position.x
	position.x = clamp(position.x + relative_movement.x, min, max_x)
	var old_y = position.y
	position.y = clamp(position.y + relative_movement.y, min, max_y)
	var old_point = arm.points[0]
	arm.points[0] = Vector2(old_point.x + old_x - position.x, old_point.y + old_y - position.y)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			update_position(event.relative)
	pass
