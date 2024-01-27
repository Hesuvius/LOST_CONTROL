extends Sprite2D

var is_remote = false
var touching = false


func _on_area_2d_body_entered(_body):
	touching = true


func _on_area_2d_body_exited(_body):
	touching = false
