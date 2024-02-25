extends AudioStreamPlayer

var audio_streams = [
	preload("res://sound and music/arm/stretch1.mp3"),
	preload("res://sound and music/arm/stretch2.mp3"),
	preload("res://sound and music/arm/stretch3.mp3")
]

func play_random_sound():
	stream = audio_streams[randi() % audio_streams.size()]
	play()
