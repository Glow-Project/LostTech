extends Control

func _ready():
	$AudioStreamPlayer.play()
	$Background/AnimationPlayer.play("Move_City")

func _process(_delta):
	if (!$AudioStreamPlayer.playing):
		$AudioStreamPlayer.play()
	if (!$Background/AnimationPlayer.is_playing()):
		$Background/AnimationPlayer.play("Move_City")

func _on_Start_pressed():
	get_tree().change_scene("res://Levels/Level1/Level1.tscn")
