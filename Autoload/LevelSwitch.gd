extends Node

export var MAX_LEVEL = 2
export var current_level_number = 1
var current_level = "Level%d" % current_level_number

# Make the next level the current level if there is one
func update_to_next_level():
	if (current_level_number != MAX_LEVEL):
		current_level_number += 1
		current_level = "Level%d" % current_level_number
