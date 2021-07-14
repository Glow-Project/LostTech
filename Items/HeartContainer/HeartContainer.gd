extends Area2D


func _ready():
	$AnimationPlayer.play("idle")

func _on_Area2D_body_entered(body):
	if (body.name == "Player"):
		get_node("../Player").regenerate_hp()
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("disappear")

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "disappear"):
		queue_free()
