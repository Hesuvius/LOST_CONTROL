extends Node2D

var slidecount = 0
var story_finished = false
var victory = true
@onready var slide_timer: Timer = $slide_timer
# ruma tapa saada lista slideistä
@onready var storySlidesList = get_tree().get_nodes_in_group("story_slides_group")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func go_to_main_game():
	get_tree().change_scene_to_file("res://main.tscn")
func show_next_slider(max):
	#start counting from 1
	max = max-1
	if slidecount <= max:
		if slidecount != 0:
			storySlidesList[slidecount-1].set_visible(false)
		storySlidesList[slidecount].set_visible(true)
		slidecount = slidecount +1
	if slidecount >= max:
		print("null")
		# turns out gd script doesn't have try-catch
		go_to_main_game()

func _on_exit_btn_pressed():
	print("exit")
	get_tree().quit()

func _on_start_btn_pressed():
	show_next_slider(5)
	$main_menu_graphics/buttons/start_btn.set_visible(false)
	$main_menu_graphics/buttons/next_btn.set_visible(true)
	#$story_slides/story1.set_visible(true)
	#slide_timer.start(5)

func _on_next_btn_pressed():
	show_next_slider(5)

func _on_slide_timer_timeout():
	go_to_main_game()
