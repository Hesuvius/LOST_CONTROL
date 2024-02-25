extends KinematicBody2D

var collision_shape
var upperArm
var openHand
var closedHand
var stretchSound

var shouldPlayStretch = true

func _ready():
	collision_shape = $CollisionShape2D
	upperArm = $UpperArm
	openHand = $OpenHand
	closedHand = $ClosedHand
	stretchSound = $StretchSound

func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			update_position(event.relative)
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if event.pressed:
				openHand.visible = false
				closedHand.visible = true
			else:
				openHand.visible = true
				closedHand.visible = false

func update_position(relative_movement):
	var viewport_rect = get_viewport().get_visible_rect()
	var bottom_right = viewport_rect.size

	var radius = collision_shape.shape.radius
	var shape_scale = collision_shape.scale.x

	var min_pos = (radius * shape_scale) / 2
	var max_x = bottom_right.x - (radius * shape_scale)
	var max_y = bottom_right.y - (radius * shape_scale)

	var old_x = position.x
	var old_y = position.y

	position.x = clamp(position.x + relative_movement.x, min_pos, max_x)
	position.y = clamp(position.y + relative_movement.y, min_pos, max_y)

	var x_change = old_x - position.x
	var y_change = old_y - position.y

	get_parent().items.move_selected_item(Vector2(-x_change, -y_change))

	var old_point = upperArm.points[0]
	upperArm.points[0] = Vector2(old_point.x + x_change, old_point.y + y_change)

	if position.y < 200 or position.x < 650 or position.x > 1700:
		shouldPlayStretch = true
	else:
		shouldPlayStretch = false

	if shouldPlayStretch and not stretchSound.playing:
		stretchSound.play()
		shouldPlayStretch = false
