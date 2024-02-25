extends AudioStreamPlayer

var audio_streams = [
	preload ("res://sound and music/trash_sounds/blop.mp3"),
	preload ("res://sound and music/trash_sounds/hrrump.mp3"),
	preload ("res://sound and music/trash_sounds/klank.mp3"),
	preload ("res://sound and music/trash_sounds/pong.mp3"),
	preload ("res://sound and music/trash_sounds/proot.mp3"),
	preload ("res://sound and music/trash_sounds/splurts.mp3")
]

func play_random_sound():
	stream = audio_streams[randi() % audio_streams.size()]
	play()
