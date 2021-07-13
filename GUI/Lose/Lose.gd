extends Control


func _on_Menu_pressed():
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_Retry_pressed():
	get_tree().change_scene("res://Levels/%s/%s.tscn" % [LevelSwitch.current_level, LevelSwitch.current_level])
