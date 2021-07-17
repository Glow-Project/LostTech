extends Node2D

var done = false

func _ready():
	if SaveData.lvl2_was_in_store:
		SaveData.lvl2_was_in_store = false
		done = true
		$Player.position = $OutsideShop.position
		$Puppy.queue_free()
	if "Techno" in SaveData.collected_casettes:
		$TechnoTrigger.queue_free()
		$TechnoAnim.queue_free()

func _process(_delta):
	if (Input.is_action_just_pressed("ui_attack") && $AnimationPlayer.current_animation == "Fighting advise"):
		$Player.attack()
		$AnimationPlayer.stop()
		_on_AnimationPlayer_animation_finished("Fighting advise")

func _on_Area2D_body_entered(body):
	if (body.name == "Player" && !done):
		done = true
		Global.is_paused = true
		$Player/Walkman.stop_song()
		$AnimationPlayer.play("Fighting Intro")

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Fighting Intro"):
		$AnimationPlayer.play("Fighting advise")
	elif (anim_name == "Fighting advise"):
		$AnimationPlayer.play("Zoom out")
	elif (anim_name == "Zoom out"):
		Global.is_paused = false
