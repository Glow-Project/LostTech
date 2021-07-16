extends AnimationPlayer

var played = false
var finished = false
var random = RandomNumberGenerator.new()
var text_collection = [
	"Trust me,\nit's save\ndown there",
	"Save the\nTimeline",
	"It will \nall make \nsense",
	"Please...",
	"I'm sorry\nfor the last\nfew levels",
	"You are\ngoing to\nunderstand",
	"It is\nnecessary"
]

func _process(_delta):
	if current_animation == "Decision Proceed":
		if Input.is_action_just_pressed("ui_accept"):
			pass
		elif Input.is_action_just_pressed("ui_up"):
			$DecisionMusic.stop()
			$CreditMusic.play()
			play("Decision Trust")
	if finished && Input.is_action_just_pressed("ui_pause"):
		get_tree().change_scene("res://Menu/Menu.tscn")
		
func _on_DescisionTrigger_body_entered(body):
	if body.name == "Player" && !played:
		Global.is_paused = true
		$DecisionMusic.play()
		play("Decision Start")


func _on_END_animation_finished(anim_name):
	if anim_name == "Decision Start":
		play("Decision Proceed")
	elif anim_name == "Decision Trust":
		SaveData.achieved_levels.append(3)
		SaveData.save_data()
		finished = true


func change_text():
	$Message.text = text_collection[random.randi_range(0, 6)]
