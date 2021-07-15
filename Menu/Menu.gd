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
	
