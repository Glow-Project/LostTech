extends Control

func _ready():
	get_node("../HUD").queue_free()
	LevelSwitch.update_to_next_level()

func _on_Menu_pressed():
	Global.is_paused = false
	Global.level_finished = false
	get_tree().change_scene("res://Menu/Menu.tscn")

func _on_Retry_pressed():
	Global.is_paused = false
	Global.level_finished = false
	get_tree().change_scene("res://Levels/%s/%s.tscn" % [LevelSwitch.current_level, LevelSwitch.current_level])
