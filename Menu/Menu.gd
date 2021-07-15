extends Control

func _ready():
	$Background/AudioStreamPlayer.play()
	$Background/AnimationPlayer.play("Move_City")
	Global.is_paused = false

func _process(_delta):
	if (!$Background/AudioStreamPlayer.playing):
		$Background/AudioStreamPlayer.play()
	if (!$Background/AnimationPlayer.is_playing()):
		$Background/AnimationPlayer.play("Move_City")
	if (!$Background/AudioStreamPlayer.is_playing()):
		$Background/AnimationPlayer.play("idle")
	if (Input.is_action_just_pressed("ui_accept")):
		_on_Start_pressed()

func _on_Start_pressed():
	get_tree().change_scene("res://Levels/%s/%s.tscn" % [LevelSwitch.current_level, LevelSwitch.current_level])


func _on_Exit_pressed():
	get_tree().quit()


func _on_Select_Level_pressed():
	$MainMenu.visible = false
	$LevelSelector.visible = true
