extends Node2D

onready var timer = $Timer
onready var items = $Items
onready var itemSounds = $ItemSounds
onready var ticking = $Ticking

var is_win = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
	var time = timer.time_left
	var seconds = int(fposmod(time, 60.0))
	if (seconds < 7):
		if not ticking.is_playing():
			ticking.play()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func win():
	is_win = true
	timer.stop()
	var win_timer = get_tree().create_timer(1.0)
	win_timer.connect("timeout", self, "_on_WinTimer_timeout")

func _on_WinTimer_timeout():
	get_tree().change_scene("res://Winning_scene/Win.tscn")
