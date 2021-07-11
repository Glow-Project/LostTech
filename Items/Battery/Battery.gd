extends Area2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	if ! $AnimationPlayer.is_playing():
		$AnimationPlayer.play("idle")


func _on_Battery_body_entered(body):
	get_parent().get_node("Player").load_battery()
	queue_free()
