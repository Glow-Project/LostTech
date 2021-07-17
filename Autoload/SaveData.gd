extends Node

var file_path = {
	"levels": "user://levels.dat",
	"casettes": "user://casettes.dat",
	"player": "user://stats.dat"
}

# Information about the Player
var player = {
	"life": null,
	"energy": null
}

# Information about the Levels 
var achieved_levels = []
var collected_casettes = []

# This variable is just used for level 2
var lvl2_was_in_store = false

# This variable is just used for Level 3
var lvl3_was_in_house = false
var lvl3_out_to_barricade = false

func _ready():
	load_data()

func save_data():
	var file = File.new()
	var error = file.open(file_path["levels"], File.WRITE)
	if error == OK:
		file.store_var(achieved_levels)
		file.close()

	file = File.new()
	error = file.open(file_path["casettes"], File.WRITE)
	if error == OK:
		file.store_var(collected_casettes)
		file.close()
		
	file = File.new()
	error = file.open(file_path["player"], File.WRITE)
	if error == OK:
		file.store_var(player)
		file.close()


func load_data():
	var file = File.new()
	if file.file_exists(file_path["levels"]):
		var error = file.open(file_path["levels"], File.READ)
		if error == OK:
			achieved_levels = file.get_var()
			file.close()
		
		if !achieved_levels.empty():
			LevelSwitch.set_current_level(achieved_levels.max())
	
	file = File.new()
	if file.file_exists(file_path["casettes"]):
		var error = file.open(file_path["casettes"], File.READ)
		if error == OK:
			collected_casettes = file.get_var()
			file.close()
			
	file = File.new()
	if file.file_exists(file_path["player"]):
		var error = file.open(file_path["player"], File.READ)
		if error == OK:
			player = file.get_var()
			file.close()

func reset():
	achieved_levels = []
	collected_casettes = []
	player = {
		"life": null,
		"energy": null
	}
	LevelSwitch.set_current_level(1)
	save_data()
