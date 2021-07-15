extends Node2D

var player_inside = false

func _ready():
	if Global.lvl3_was_in_house:
		$Player.position = $Position2D.position

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") && player_inside:
		Global.save_player_pos = $Player.position
		get_tree().change_scene("res://Levels/Level3/House/House.tscn")
		Global.lvl3_was_in_house = true
		
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_inside = true

func _on_Area2D_body_exited(body):
	player_inside = false
