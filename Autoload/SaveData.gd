extends Node

var file_path = {
	"levels": "user://levels.dat",
	"casettes": "user://casettes.dat"}

# Information about the Levels 
var achieved_levels = []
var collected_casettes = []

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


func load_data():
	var file = File.new()
	if file.file_exists(file_path["levels"]):
		var error = file.open(file_path["levels"], File.READ)
		if error == OK:
			achieved_levels = file.get_var()
			file.close()
	
	file = File.new()
	if file.file_exists(file_path["casettes"]):
		var error = file.open(file_path["casettes"], File.READ)
		if error == OK:
			collected_casettes = file.get_var()
			file.close()

