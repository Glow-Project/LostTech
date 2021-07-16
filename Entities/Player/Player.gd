extends KinematicBody2D

export var life = 5
export var battery_level = 100
export var attack_delay: float = 0.5

var vel = Vector2.ZERO
var SPEED = 35
var JUMP_HEIGHT = 120
var looks_right = true
var just_jumped = false
var on_floor: bool = true
var player_paused = false

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
		
	if (battery_level == -0): battery_level = 0
		
	if (battery_level <= 0 && !$Walkman.paused):
		play_or_stop($Walkman.current_song.name, true)

func _physics_process(_delta):
	if (Global.is_paused):
		if (!$AttackDelayTimer.is_stopped()):
			$AnimatedSprite.play("attack")
		else:
			$AnimatedSprite.play("idle")
		return
	
	if (position.y > 240):
		lose()
	
	if (!$AnimationPlayer.is_playing()):
		$AnimatedSprite.play(move())
	else:
		move()

func move():
	if vel.x != 0: vel.x /= 2
	vel.y += Global.GRAVITY
	var action = "idle"
	
	if (Input.is_action_pressed("ui_right") && 
		!$AnimationPlayer.is_playing()):
		vel.x = SPEED
		action = "walk"
		flip_if_needed(true)
		walk_sound()
		
	if (Input.is_action_pressed("ui_left") &&
		!$AnimationPlayer.is_playing()):
		flip_if_needed(false)
		vel.x = -SPEED
		action = "walk"
		walk_sound()
		
	if (Input.is_action_pressed("ui_shift") && (
		Input.is_action_pressed("ui_right") || 
		Input.is_action_pressed("ui_left")) &&
		!$AnimationPlayer.is_playing()):
		vel.x *= 2
		action = "run"
	
	var song = $Walkman.current_song
	var song_name
	if (is_instance_valid(song)):
		song_name = song.name
	else:
		song_name = "null"
	
	if (Input.is_action_just_pressed("1") && (song_name == "Classic" || song_name == "null")):
		play_or_stop("Classic")
	elif (Input.is_action_just_pressed("2") && (song_name == "Raggea" || song_name == "null")):
		play_or_stop("Raggea")	
	elif (Input.is_action_just_pressed("3") && (song_name == "Techno" || song_name == "null")):
		play_or_stop("Techno")
	
	if (Input.is_action_just_pressed("ui_attack") && $AttackDelayTimer.is_stopped()):
		attack()
	
	vel = move_and_slide(vel)

	on_floor = false
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if (collision.collider is TileMap):
			on_floor = true

	if (vel.y > 0 || (vel.y == 0 && just_jumped) && !$AnimationPlayer.is_playing() && !on_floor):
		action = "fall"
		just_jumped = false
	elif (vel.y < 0 && !$AnimationPlayer.is_playing() && !on_floor):
		action = "jump"
		just_jumped = true

	if (Input.is_action_just_pressed("ui_up") && on_floor &&
		!$AnimationPlayer.is_playing()):
		vel.y += -JUMP_HEIGHT
		$JumpSound.play()

	return action

func attack():
	$AttackDelayTimer.start(attack_delay)
	$AnimationPlayer.play("attack")

func play_or_stop(name, forced=false):
	if ((!(name in SaveData.collected_casettes) ||
		battery_level <= 0) && !forced):
		return
	if ($Walkman.paused):
		$Walkman.play_song(name)
	else:
		$Walkman.stop_song()
		name = "none"
	var hud = get_node_or_null("../Camera/HUD")
	if(is_instance_valid(hud)):
		hud.change_casette(name)

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
	if (!player_paused && !Global.is_paused):
		var cam = get_node("../Camera")
		var pause_scene = load("res://GUI/Pause/Pause.tscn")
		cam.add_child(pause_scene.instance())
		Global.is_paused = true
		player_paused = true
	elif (player_paused):
		var pause = get_node_or_null("../Camera/Pause")
		if (is_instance_valid(pause)):
			pause.queue_free()
		Global.is_paused = false
		player_paused = false

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

func cut():
	if (!$Walkman.paused):
		play_or_stop($Walkman.current_song.name, true)

func _on_Area2D_body_entered(body):
	if (!(body is TileMap) && body.name != "Player"):
		body.get_hit()

func walk_sound():
	if (!$WalkSound.playing && on_floor):
		$WalkSound.play()
