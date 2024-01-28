extends CharacterBody2D

@onready var collision_shape = $CollisionShape2D
@onready var upperArm = $UpperArm
@onready var openHand = $OpenHand
@onready var closedHand = $ClosedHand
@onready var stretchSound = $StretchSound

var shouldPlayStretch = true


func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			update_position(event.relative)
		if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				openHand.visible = false
				closedHand.visible = true
			else:
				openHand.visible = true
				closedHand.visible = false
	pass


func update_position(relative_movement):
	var viewport_rect = get_viewport_rect()
	var bottom_right = viewport_rect.end

	var radius = collision_shape.shape.radius
	var scale = collision_shape.scale.x
	
	var min = (radius * scale) / 2
	var max_x = bottom_right.x - (radius * scale)
	var max_y = bottom_right.y - (radius * scale)

	var old_x = position.x
	var old_y = position.y

	position.x = clamp(position.x + relative_movement.x, min, max_x)
	position.y = clamp(position.y + relative_movement.y, min, max_y)
	
	var x_change = old_x - position.x
	var y_change = old_y - position.y
	
	get_parent().items.move_selected_item(Vector2(-x_change, -y_change))

	var old_point = upperArm.points[0]
	upperArm.points[0] = Vector2(old_point.x + x_change, old_point.y + y_change)


	if position.y < 200 || position.x < 650 || position.x > 1700:
		shouldPlayStretch = true
	else:
		shouldPlayStretch = false
	
	if shouldPlayStretch && !stretchSound.playing:
		stretchSound.play()
		shouldPlayStretch = false

