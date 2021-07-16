extends Control

func _ready():
	if 1 in SaveData.achieved_levels:
		$Level1.visible = true
	if 2 in SaveData.achieved_levels:
		$Level2.visible = true
	if 3 in SaveData.achieved_levels:
		$Level3.visible = true

func _on_Level1_pressed():
	set_and_load(1)

func _on_Level2_pressed():
	set_and_load(2)
	
func _on_Level3_pressed():
	set_and_load(3)

func _on_Back_pressed():
	visible = false
	get_parent().get_node("MainMenu").visible = true

func set_and_load(num):
	LevelSwitch.set_current_level(num)
	get_tree().change_scene("res://Levels/%s/%s.tscn" % [LevelSwitch.current_level, LevelSwitch.current_level])
