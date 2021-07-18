extends Area2D


func _ready():
	$AnimationPlayer.play("idle")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		queue_free()
