extends KinematicBody2D

export var SPEED: float = 50
export var JUMP_HEIGHT: float = 1
export var friendly: bool = false
export var attack_delay: float = 2

var vel = Vector2.ZERO
var dead = false
var looks_right = true
var random = RandomNumberGenerator.new()

func _physics_process(_delta):
	if (Global.is_paused): return
	if (SPEED != 0): SPEED = Global.enemy_speed
	check_death()

	friendly = Global.friendly
	$AnimatedSprite.play(move())

func move():
	var action = "idle"
	var player = get_node_or_null("../Player")
	vel.x = 0
	vel.y += Global.GRAVITY
	
	# play idle if there is no Player
	if (!is_instance_valid(player)):
		return action
	
	# Calculate the distance between entity and Player
	var distance = player.position - position
	distance.y = round(distance.y)
	distance.x = round(distance.x)
	distance.y += 12

	# play idle if the player is too far away
	if (distance.x > 250 || distance.x < -250):
		return action

	# Check if the player isn't jumping
	if (!dead && !((distance.x > -70 && distance.x < 70) && 
		distance.y < 0) && $AttackDelayTimer.is_stopped() &&
		!friendly):
		if (distance.x < 0):
			vel.x -= SPEED
			flip_if_needed(false)
			action = "run"
		else:
			vel.x += SPEED
			flip_if_needed(true)
			action = "run"
			
	# Check if the player is about to jump on the entity
	elif (!dead && 
		(distance.x < 60 && distance.x > -60) && 
		(distance.y < -5 && distance.y > -50) && 
		$AttackDelayTimer.is_stopped() &&
		!friendly): 
			if (distance.x < 0):
				vel.x += SPEED
				flip_if_needed(true)
				action = "run"
			else:
				vel.x -= SPEED
				flip_if_needed(false)
				action = "run"
		

	vel = move_and_slide(vel)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)

		if (collision.collider.name == "Player" && !friendly):
			if ((distance.y == 0 || distance.y > 0) && 
				$AttackDelayTimer.is_stopped() &&
				!friendly):
				$AttackDelayTimer.start(attack_delay)
				attack()
				action = "attack"
			elif (distance.y < 0):
				get_node("../Player").bump()
				die()
	
	if ($BarkIntervalTimer.is_stopped() && !dead):
		$BarkIntervalTimer.start(random.randi_range(1, 5))
	
	if dead:
		action = "hurt"
	
	return action

func get_hit():
	die()

func attack():
	get_node("../Player").get_hit()

func flip_if_needed(should_look_right):
	if (looks_right == should_look_right): 
		return
	else:
		looks_right = should_look_right
		scale.x *= -1

func check_death():
	if (position.y > 250):
		queue_free()

func die():
	$CollisionShape2D.queue_free()
	$AudioStreamPlayer2D.play()
	$AnimatedSprite.play("hurt")
	dead = true


func _on_BarkIntervalTimer_timeout():
	get_node("Bark%d" % random.randi_range(1,3)).play()
