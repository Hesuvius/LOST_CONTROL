extends Node2D

var slidecount = 0
var story_finished = false
var victory = true

onready var slide_timer = $slide_timer
onready var storySlidesList = get_tree().get_nodes_in_group("story_slides_group")
onready var slidesmax = storySlidesList.size() - 1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func go_to_main_game():
	get_tree().change_scene("res://main.tscn")
func show_next_slider():
	if slidecount <= slidesmax - 1:
		if slidecount != 0:
			storySlidesList[slidecount-1].visible = false
		storySlidesList[slidecount].visible = true
		slidecount += 1
	else:
		go_to_main_game()

func _on_exit_btn_pressed():
	get_tree().quit()

func _on_start_btn_pressed():
	$buttons/exit_btn.visible = false
	$buttons/start_btn.visible = false
	$buttons/next_btn.visible = true
	show_next_slider()
	# slide_timer.start(5)

func _on_next_btn_pressed():
	print("pressed")
	show_next_slider()

func _on_slide_timer_timeout():
	go_to_main_game()
