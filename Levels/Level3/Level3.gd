extends Node2D

var player_inside = false

func _ready():
	if SaveData.lvl3_was_in_house:
		$Player.position = $HouseMainDoor.position
		SaveData.lvl3_was_in_house = false
	elif SaveData.lvl3_out_to_barricade:
		$Player.position = $HouseBarricadeDoor.position
		SaveData.lvl3_out_to_barricade = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") && player_inside:
		get_tree().change_scene("res://Levels/Level3/House/House.tscn")
		
	$Particles2D.visible = true
		
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_inside = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_inside = false
