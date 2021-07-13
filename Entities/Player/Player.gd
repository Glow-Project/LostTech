extends KinematicBody2D

export var life = 5
export var battery_level = 100
var vel = Vector2.ZERO
var SPEED = 35
var JUMP_HEIGHT = 120
var looks_right = true
var just_jumped = false

func _ready():
	var simple_bat = battery_level
	if (simple_bat != 0):
		simple_bat = battery_level * 4 / 100
		simple_bat = round(simple_bat)
	
	get_node("../Camera/HUD").change_life(str(life))
	get_node("../Camera/HUD").change_battery(str(simple_bat))

func _process(_delta):
	if (Input.is_action_just_pressed("ui_pause") && !Global.level_finished):
		toggle_pause()

func _physics_process(_delta):
	if (Global.is_paused):
		return
	
	if (position.y > 240):
		lose()

	$AnimatedSprite.play(move())

func move():
	vel.x = 0
	vel.y += Global.GRAVITY
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
	
	if (Input.is_action_just_pressed("ui_up") && vel.y == Global.GRAVITY):
		vel.y += -JUMP_HEIGHT
	
	vel = move_and_slide(vel)

	if (vel.y > 0 || (vel.y == 0 && just_jumped)):
		action = "fall"
		just_jumped = false
	elif (vel.y < 0):
		action = "jump"
		just_jumped = true

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
	
	# Calculate the energy bars
	if (battery_level != 0):
		simple_bat = battery_level * 4 / 100
		simple_bat = round(simple_bat)
	else:
		simple_bat = battery_level
		
	# update HUD
	get_node("../Camera/HUD").change_battery(str(simple_bat))

func regenerate_hp(amount=1):
	# Append the life if it i'snt max
	if (life != 5):
		life += amount
		if (life > 5): life = 5
		
		# Update the HUD
		get_node("../Camera/HUD").change_life(str(life))

func get_hit(damage=1):
	$AnimatedSprite.play("hurt")
	$Damage.play()
	life -= damage
	if (life <= 0):
		lose()
	get_node("../Camera/HUD").change_life(str(life))

func toggle_pause():
	if (!Global.is_paused):
		var cam = get_node("../Camera")
		var pause_scene = load("res://GUI/Pause/Pause.tscn")
		cam.add_child(pause_scene.instance())
		Global.is_paused = true
	else:
		get_node("../Camera/Pause").queue_free()
		Global.is_paused = false

func bump(amount=JUMP_HEIGHT):
	
	# Append velocity
	vel.y = -amount

func lose():
	
	# Remove the HUD
	get_node("../Camera/HUD").queue_free()
	
	# Load the 'lose' scene
	var lose_scene = load("res://GUI/Lose/Lose.tscn")
	var lose = lose_scene.instance()
	
	# Make the 'lose' scene a child of the Camera
	get_node("../Camera").add_child(lose)
	
	# Delete self
	queue_free()
