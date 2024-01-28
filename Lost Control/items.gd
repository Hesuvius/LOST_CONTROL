extends Node

var items = []
var selected = null
var rng = RandomNumberGenerator.new()


func _ready():
	var raw_items = get_children()
	for child in raw_items:
		remove_child(child)

	var remote = raw_items[0].duplicate()
	items.append(remote)

	for n in 128:
		var duplicate_item = raw_items[rng.randi_range(1, raw_items.size() - 1)].duplicate()
		items.append(duplicate_item)
	
	var z_index = 0
	for item in items:
		item.position.x = rng.randi_range(270, 1695)
		item.position.y = rng.randi_range(245, 900)
		item.rotation = rng.randi_range(0, 360)
		item.z_index = z_index
		z_index += 1
		add_child(item)


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
				get_parent().itemSounds.play()


func move_selected_item(movement: Vector2):
	if selected:
		selected.position.x += movement.x
		selected.position.y += movement.y


func update_z_indices(new_top_item: Node):
	items.sort_custom(sort_items)
	
	var z_index = 0
	for item in items:
		if item != new_top_item:
			item.z_index = z_index
			z_index += 1
	if new_top_item:
		new_top_item.z_index = z_index


func sort_items(a, b):
	return a.z_index < b.z_index


func select_top_item():
	var highest_z_index = -1
	for item in items:
		if item.touching and item.z_index > highest_z_index:
			highest_z_index = item.z_index
			selected = item
