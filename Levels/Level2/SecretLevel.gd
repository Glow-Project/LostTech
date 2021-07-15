extends Area2D

var floors_traveled = 0
var MAX_FLOORS = 3
var activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activated && Input.is_action_just_pressed("ui_accept"):
		Global.is_paused = true
		$AnimationPlayer.play("elevator_intro")

func _on_SecretLevel_body_entered(body):
	if body.name == "Player":
		activated = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "elevator_intro":
		$AnimationPlayer.play("elevator_up")
	elif anim_name == "elevator_up":
		# Travel floors up until the deck has been reached
		if floors_traveled < MAX_FLOORS:
			floors_traveled += 1
			$AnimationPlayer.play("elevator_up")
		else:
			activated = false
			floors_traveled = 0
			$AnimationPlayer.play("elevator_stop")
	elif anim_name == "elevator_stop":
		$AnimationPlayer.stop()
		Global.is_paused = false
