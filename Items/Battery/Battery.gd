extends Area2D

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if ! $AnimationPlayer.is_playing():
		$AnimationPlayer.play("idle")

func _on_Battery_body_entered(body):
	if (body.name == "Player"):
		$AudioStreamPlayer.play()
		get_parent().get_node("Player").load_battery()
		visible = false

func _on_AudioStreamPlayer_finished():
	queue_free()
