extends Node

export var MAX_LEVEL: int = 2
export var current_level_number: int = 1
var current_level: String = "Level%d" % current_level_number

# Make the next level the current level if there is one
func update_to_next_level():
	if (current_level_number != MAX_LEVEL):
		current_level_number += 1
		current_level = "Level%d" % current_level_number

func set_current_level(num: int):
	current_level_number = num
	current_level = "Level%d" % current_level_number
