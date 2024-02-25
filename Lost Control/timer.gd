extends Timer

func _ready():
	pass

func _process(_delta):
	pass

func _on_timeout():
	get_tree().change_scene("res://Lose_scene/Lose.tscn")
