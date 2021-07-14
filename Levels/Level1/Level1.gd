extends Node2D

var puppy_introduced = false

func _ready():
	Global.is_paused = true
	$AnimationPlayer.play("Outta Club")

func _on_Area2D_body_entered(body):
	if (body.name == "Player" && !puppy_introduced):
		Global.is_paused = true
		$AnimationPlayer.play("Introduce Puppy")
		puppy_introduced = true

func _on_AnimationPlayer_animation_finished(anim_name):
	Global.is_paused = false
	if (anim_name == "Introduce Puppy"):
		$Puppy.SPEED = $Puppy2.SPEED
