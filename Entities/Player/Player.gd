extends KinematicBody2D

export var life = 100
export var battery_level = 100
var vel = Vector2.ZERO
var SPEED = 25
var GRAVITY = 2
var JUMP_HEIGHT = 90
var looks_right = true

func _ready():
	var simple_bat = battery_level
	if (simple_bat != 0):
		simple_bat = battery_level * 4 / 100
		simple_bat = round(simple_bat)
	
	get_node("../Camera/HUD").change_battery(str(simple_bat))

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

func load_battery(level=25):
	# ensure that battery can't get over 100
	battery_level = min(battery_level + level, 100) 
	
	var simple_bat
	
	if (battery_level != 0):
		simple_bat = battery_level * 4 / 100
		simple_bat = round(simple_bat)
	else:
		simple_bat = battery_level
		
	# update HUD
	get_node("../Camera/HUD").change_battery(str(simple_bat))
