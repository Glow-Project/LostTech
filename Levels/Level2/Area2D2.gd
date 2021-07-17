extends Area2D

var player_inside = false

func _process(_delta):
	if player_inside && Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Levels/Level2/Shop.tscn")

func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		player_inside = true

func _on_Area2D2_body_exited(body):
	if body.name == "Player":
		player_inside = false
