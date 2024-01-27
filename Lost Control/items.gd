extends Node

var items = []
var selected = null


func _ready():
	items = get_children()
	pass


func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				selected = find_highest_touching_node()
				if selected:
					update_z_indices(selected)
			else:
				selected = null
		if selected && event is InputEventMouseMotion:
			var relative_movement = event.relative
			selected.position.x = selected.position.x + relative_movement.x
			selected.position.y = selected.position.y + relative_movement.y


func update_z_indices(new_top_item: Node):
	var max_z_index = items.size()
	for item in items:
		if item == new_top_item:
			item.z_index = max_z_index
		else:
			max_z_index -= 1
			item.z_index = max_z_index


func find_highest_touching_node() -> Node:
	var top_item = null
	var highest_z_index = -1
	
	for item in items:
		if item.touching and item.z_index > highest_z_index:
			highest_z_index = item.z_index
			top_item = item
	
	return top_item

