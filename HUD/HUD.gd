extends Control


func change_battery(animation):
	$Stats/Energy/Energy.play(animation)

func change_life(animation):
	$Stats/Life/Life.play(animation)
