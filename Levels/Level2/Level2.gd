extends Node2D

var done = false


func _process(_delta):
	if (Input.is_action_just_pressed("ui_attack") && $AnimationPlayer.current_animation == "Fighting advise"):
		$Player.attack()
		$AnimationPlayer.stop()
		_on_AnimationPlayer_animation_finished("Fighting advise")

func _on_Area2D_body_entered(body):
	if (body.name == "Player" && !done):
		done = true
		Global.is_paused = true
		$AnimationPlayer.play("Fighting Intro")

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Fighting Intro"):
		$AnimationPlayer.play("Fighting advise")
	elif (anim_name == "Fighting advise"):
		$AnimationPlayer.play("Zoom out")
	elif (anim_name == "Zoom out"):
		Global.is_paused = false
