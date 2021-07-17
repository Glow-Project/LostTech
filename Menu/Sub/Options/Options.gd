extends Control

func _on_Back_pressed():
	visible = false
	get_parent().get_node("MainMenu").visible = true

func _on_Reset_pressed():
	SaveData.reset()
	SaveData.load_data()
	get_parent().get_node("LevelSelector")._on_LevelSelector_draw()
	$Reset.visible = false
