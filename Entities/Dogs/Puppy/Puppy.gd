extends KinematicBody2D

export var SPEED = 50
export var JUMP_HEIGHT = 1
var vel = Vector2.ZERO
var cooldown = 1.5
var counter = 0
var hit = false
var dead = false
var looks_right = true

func _physics_process(delta):
	if (Global.is_paused):
		return
	check_death()
	
	if (hit):
		counter += delta
		if (counter >= cooldown):
			hit = false
			counter = 0
		else:
			$AnimatedSprite.play("attack")
			return
	$AnimatedSprite.play(move())

func move():
	var action = "idle"
	var player = get_node_or_null("../Player")
	vel.x = 0
	vel.y += Global.GRAVITY
	if (!is_instance_valid(player)):
		return action
	
	var distance = player.position - position
	distance.y = round(distance.y)
	distance.x = round(distance.x)
	distance.y += 12

	if (distance.x > 250 || distance.x < -250):
		return action

	# Check if the player isn't jumping
	if (!dead && !((distance.x > -70 && distance.x < 70) && distance.y < 0)):
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
		(distance.y < -5 && distance.y > -50)): 
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

		if (collision.collider.name == "Player" && !hit):
			if (distance.y == 0 || distance.y > 0):
				attack()
				action = "attack"
			else:
				get_node("../Player").bump()
				die()
				
	return action

func attack():
	get_node("../Player").get_hit()
	hit = true

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
	dead = true
