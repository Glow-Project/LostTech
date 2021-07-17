extends Node2D

export var paused = true
var current_song = null
var required_energy = {
	"Classic": 12,
	"Techno": 10,
	"Raggea": 23
}

func _process(delta):
	if (!paused && !current_song.playing):
		current_song.play()
	if (!paused):
		get_parent().load_battery(-delta*required_energy[current_song.name])

func play_song(name):
	current_song = get_node(name)
	current_song.play()
	paused = false
	proceed_effect(name, true)

func stop_song():
	current_song.stop()
	paused = true
	proceed_effect(current_song.name, false)
	current_song = null

func proceed_effect(name, on):
	if (on == true):
		if (name == "Classic"):
			Global.friendly = true
		elif (name == "Raggea"):
			Global.GRAVITY = -0.5
		elif (name == "Techno"):
			get_parent().SPEED = get_parent().SPEED * 2
	else:
		if (name == "Classic"):
			Global.friendly = false
		elif (name == "Raggea"):
			Global.GRAVITY = 3
		elif (name == "Techno"):
			get_parent().SPEED = get_parent().SPEED / 2
	
