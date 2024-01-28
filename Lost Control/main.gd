extends Node2D

@onready var timer = $Timer
@onready var items = $Items
@onready var itemSounds = $ItemSounds

var is_win = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseButton:
		if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func win():
	is_win = true
	timer.stop()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Winning_scene/Win.tscn")
