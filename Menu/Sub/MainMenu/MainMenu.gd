extends Control

func _process(_delta):
	if (Input.is_action_just_pressed("ui_accept")):
		_on_Start_pressed()

func _on_Start_pressed():
	get_tree().change_scene("res://Levels/%s/%s.tscn" % [LevelSwitch.current_level, LevelSwitch.current_level])

func _on_Exit_pressed():
	get_tree().quit()
	
func _on_Select_Level_pressed():
	switch_interface("LevelSelector")

func _on_Options_pressed():
	switch_interface("Options")
	
func switch_interface(scene_name):
	visible = false
	get_parent().get_node(scene_name).visible = true
