extends AnimationPlayer

export var typing_speed: float = 0.05

var played = false
var type = false

func _process(_delta):
	if current_animation == "Techno proceed" && Input.is_action_just_pressed("ui_accept"):
		get_node("../Player/Walkman/Techno").stop()
		play("Techno End")
	if type && $TechnoTut/Timer.is_stopped():
		$TechnoTut/Timer.start(typing_speed)

func _on_TechnoTrigger_body_entered(body):
	if body.name == "Player" && !played:
		Global.is_paused = true
		play("Techno Introduction")
		played = true


func _on_TechnoAnim_animation_finished(anim_name):
	if anim_name == "Techno Introduction":
		get_node("../Player/Walkman/Techno").play()
		play("Techno proceed")
	elif anim_name == "Techno End":
		Global.is_paused = false


func _on_Techno_body_exited(body):
	type = true

func _on_Timer_timeout():
	$TechnoTut.visible_characters += 1
