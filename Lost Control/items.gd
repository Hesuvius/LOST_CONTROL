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
				select_top_item()
				if selected:
					update_z_indices(selected)
					if (selected.is_remote):
						get_parent().win()
			else:
				selected = null
		if selected && event is InputEventMouseMotion:
			var relative_movement = event.relative
			selected.position.x = selected.position.x + relative_movement.x
			selected.position.y = selected.position.y + relative_movement.y


func update_z_indices(new_top_item: Node):
	items.sort_custom(sort_items)
	
	var z_index = 0
	for item in items:
		if item != new_top_item:
			item.z_index = z_index
			z_index += 1
	new_top_item.z_index = z_index


func sort_items(a, b):
	return a.z_index < b.z_index


func select_top_item():
	var highest_z_index = -1
	for item in items:
		if item.touching and item.z_index > highest_z_index:
			highest_z_index = item.z_index
			selected = item
