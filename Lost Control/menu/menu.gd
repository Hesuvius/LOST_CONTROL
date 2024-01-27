extends Node2D


func _on_exit_btn_pressed():
	print("exit")
	get_tree().quit()


func _on_start_btn_pressed():
	print("start")
	get_tree().change_scene_to_file("res://main.tscn")


func _on_next_btn_pressed():
	print("next")
