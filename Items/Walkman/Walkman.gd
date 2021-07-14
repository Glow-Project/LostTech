extends Node2D

var paused = true
var current_song = null

func _process(_delta):
	if (!paused && !current_song.playing):
		current_song.play()

func play_song(name):
	current_song = get_node(name)
	current_song.play()
	paused = false

func stop_song():
	current_song.stop()
	paused = true
