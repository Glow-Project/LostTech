extends Node2D

var puppy_introduced = false
var casette_introduced = false

func _ready():
	Global.is_paused = true
	$AnimationPlayer.play("Outta Club")

func _process(_delta):
	if ($AnimationPlayer.is_playing() && 
		$AnimationPlayer.current_animation == "Proceed Casette" &&
		Input.is_action_just_pressed("ui_accept")):
			$Player/Walkman/Classic.stop()
			$AnimationPlayer.play("Exit Casette intro")

func _on_Area2D_body_entered(body):
	if (body.name == "Player" && !puppy_introduced):
		Global.is_paused = true
		$AnimationPlayer.play("Introduce Puppy")
		puppy_introduced = true

func _on_AnimationPlayer_animation_finished(anim_name):
	Global.is_paused = false
	if (anim_name == "Introduce Puppy"):
		$Puppy.SPEED = $Puppy2.SPEED
	elif (anim_name == "Introduce Casette" && !casette_introduced):
		Global.is_paused = true
		$AnimationPlayer.play("Proceed Casette")
		$Player/Walkman/Classic.play()
		casette_introduced = true


func _on_ClassicCasetteIntroduction_body_entered(body):
	if (body.name == "Player" && !casette_introduced):
		Global.is_paused = true
		$AnimationPlayer.play("Introduce Casette")
		
