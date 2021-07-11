extends KinematicBody2D

var vel = Vector2.ZERO
var SPEED = 25
var GRAVITY = 2
var JUMP_HEIGHT = 75
var looks_right = true
var battery_level = 20
var life = 100

func _ready():
	# initialize HUD
	get_node("../HUD/Stats/Energy/ProgressBar").value = battery_level
	get_node("../HUD/Stats/Life/ProgressBar").value = life	

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

func load_battery(level=10):
	# ensure that battery can't get over 100
	battery_level = min(battery_level + level, 100) 
	
	# update HUD
	get_node("../HUD/Stats/Energy/ProgressBar").value = battery_level
