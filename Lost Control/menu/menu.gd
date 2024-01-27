extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

var story_finished = false
var victory = true
@onready var slide_timer: Timer = $slide_timer
# ruma tapa saada lista slideistä
@onready var storySlidesList = get_tree().get_nodes_in_group("story_slides_group")

func _on_exit_btn_pressed():
	print("exit")
	get_tree().quit()

func _on_start_btn_pressed():
	print("listing",storySlidesList)
	$main_menu_graphics/buttons/start_btn.set_visible(false)
	$main_menu_graphics/buttons/next_btn.set_visible(true)
	$story_slides/story1.set_visible(true)
	slide_timer.start(5)

func _on_next_btn_pressed():
	print("next")


func _on_slide_timer_timeout():
	get_tree().change_scene_to_file("res://main.tscn")

