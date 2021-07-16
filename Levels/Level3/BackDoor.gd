extends Area2D

var player_inside

func _process(_delta):
	if (player_inside && Input.is_action_just_pressed("ui_accept")):
		get_tree().change_scene("res://Levels/Level3/House/House.tscn")
		SaveData.lvl3_out_to_barricade = true

func _on_BackDoor_body_exited(body):
	if (body.name == "Player"):
		player_inside = false

func _on_BackDoor_body_entered(body):
	if (body.name == "Player"):
		player_inside = true

