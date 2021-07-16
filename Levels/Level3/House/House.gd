extends Node2D

func _ready():
	if SaveData.lvl3_out_to_barricade:
		$Player.position = $BackDoorPosition.position
		SaveData.lvl3_out_to_barricade = false
