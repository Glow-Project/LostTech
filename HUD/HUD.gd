extends Control

var energy
var life

func change_battery(animation):
	$Stats/Energy/Energy.play(animation)
	energy = animation

	if (int(energy) == 1):
		$Stats/Energy/AnimationPlayer.play("low_battery")
	else:
		$Stats/Energy/AnimationPlayer.stop()

func change_life(animation):
	$Stats/Life/Life.play(animation)
	life = animation
	if (int(life) == 1):
		$Stats/Life/AnimationPlayer.play("low_hp")
	else:
		$Stats/Life/AnimationPlayer.stop()
	
