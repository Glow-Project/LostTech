extends Control

var done = false

func _ready():
	if !Global.is_playing:
		$Intro/AnimationPlayer.play("Intro")
	else:
		$Background/AudioStreamPlayer.play()
		$Background/AnimationPlayer.play("Move_City")
		Global.is_paused = false

func _process(_delta):
	if !$Intro/AnimationPlayer.is_playing() && !done:
		$Intro.visible = false
		$MainMenu.visible = true
		$Background.visible = true
		done = true
	
	if (!$Background/AudioStreamPlayer.playing && $Background.visible):
		$Background/AudioStreamPlayer.play()
	if (!$Background/AnimationPlayer.is_playing() && $Background.visible):
		$Background/AnimationPlayer.play("Move_City")
	if (!$Background/AudioStreamPlayer.is_playing() && $Background.visible):
		$Background/AnimationPlayer.play("idle")
	
