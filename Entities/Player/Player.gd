extends KinematicBody2D

var vel = Vector2.ZERO
var SPEED = 20
var GRAVITY = 1
var looks_right = true

func _process(delta):
	$AnimatedSprite.play(move_player())

func move_player():
	vel.x = 0
	vel.y += GRAVITY
	var action = "idle"
	
	if (Input.is_action_pressed("ui_right")):
		vel.x = SPEED
		action = "walk"
		flip_if_needed(true)
		
	if (Input.is_action_pressed("ui_left")):
		flip_if_needed(false)
		vel.x = -SPEED
		action = "walk"
	
	vel = move_and_slide(vel)
	
	return action
	
func flip_if_needed(should_look_right):
	if (looks_right == should_look_right): 
		return
	else:
		looks_right = should_look_right
		scale.x *= -1
