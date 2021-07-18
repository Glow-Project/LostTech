extends Node2D

func _ready():
	if SaveData.lvl3_out_to_barricade:
		$Player.position = $BackDoorPosition.position
		SaveData.lvl3_out_to_barricade = false
	$BackgroundMusic.play(SaveData.lvl3_music_loc)


func _on_Node2D_tree_exited():
	SaveData.lvl3_music_loc = $BackgroundMusic.get_playback_position()
