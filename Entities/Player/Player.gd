extends KinematicBody2D

var vel = Vector2.ZERO
var SPEED = 25
var GRAVITY = 2
var JUMP_HEIGHT = 75
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
		
	if (Input.is_action_just_pressed("ui_up") && vel.y == GRAVITY):
		vel.y += -JUMP_HEIGHT
	
	if (Input.is_action_pressed("ui_shift")):
		vel.x *= 2
	
	vel = move_and_slide(vel)
	
	return action
	
func flip_if_needed(should_look_right):
	if (looks_right == should_look_right): 
		return
	else:
		looks_right = should_look_right
		scale.x *= -1
