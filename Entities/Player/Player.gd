extends KinematicBody2D

export var life = 100
export var battery_level = 100
var vel = Vector2.ZERO
var SPEED = 35
var GRAVITY = 3
var JUMP_HEIGHT = 115
var looks_right = true

func _ready():
	var simple_bat = battery_level
	if (simple_bat != 0):
		simple_bat = battery_level * 4 / 100
		simple_bat = round(simple_bat)
	
	get_node("../Camera/HUD").change_battery(str(simple_bat))

func _process(delta):
	if (position.y > 240):
		lose()
	
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
		
	if (Input.is_action_pressed("ui_shift") && (
		Input.is_action_pressed("ui_right") || 
		Input.is_action_pressed("ui_left"))):
		vel.x *= 2
		action = "run"
	
	if (Input.is_action_just_pressed("ui_up") && vel.y == GRAVITY):
		vel.y += -JUMP_HEIGHT
	
	if (vel.y > GRAVITY):
		action = "fall"
	elif (vel.y < GRAVITY):
		action = "jump"
	
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

func lose():
	get_node("../Camera/HUD").queue_free()
	var lose_scene = load("res://GUI/Lose/Lose.tscn")
	var lose = lose_scene.instance()
	get_node("../Camera").add_child(lose)
	queue_free()
