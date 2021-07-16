extends Area2D

var player_inside

func _process(_delta):
	if (player_inside && Input.is_action_just_pressed("ui_accept")):
		get_tree().change_scene("res://Levels/Level3/Level3.tscn")

func _on_Door_body_entered(body):
	if (body.name == "Player"):
		player_inside = true

func _on_Door_body_exited(body):
	if (body.name == "Player"):
		player_inside = false
