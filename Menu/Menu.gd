extends Control

func _ready():
	$AudioStreamPlayer.play()
	$Background/AnimationPlayer.play("Move_City")

func _process(_delta):
	if (!$AudioStreamPlayer.playing):
		$AudioStreamPlayer.play()
	if (!$Background/AnimationPlayer.is_playing()):
		$Background/AnimationPlayer.play("Move_City")
	if (!$AnimationPlayer.is_playing()):
		$AnimationPlayer.play("idle")

func _on_Start_pressed():
	get_tree().change_scene("res://Levels/%s/%s.tscn" % [LevelSwitch.current_level, LevelSwitch.current_level])
	
