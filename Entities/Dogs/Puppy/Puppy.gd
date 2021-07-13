extends KinematicBody2D

export var SPEED = 50
export var JUMP_HEIGHT = 1
var vel = Vector2.ZERO
var cooldown = 1.5
var counter = 0
var hit = false
var dead = false

func _physics_process(delta):
	if (Global.is_paused):
		return
	check_death()
	
	if (hit):
		counter += delta
		if (counter >= cooldown):
			hit = false
			counter = 0
	move()

func move():
	var player = get_node_or_null("../Player")
	vel.x = 0
	vel.y += Global.GRAVITY
	if (!is_instance_valid(player)):
		return
	
	var distance = player.position - position
	distance.y = round(distance.y)
	distance.y += 12


	if (distance.x > 250 || distance.x < -250):
		return

	if (!dead):
		if (distance.x < 0):
			vel.x -= SPEED
		else:
			vel.x += SPEED

	if (!dead && is_on_wall()):
		vel.y -= JUMP_HEIGHT

	vel = move_and_slide(vel)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if (collision.collider.name == "Player" && !hit):
			if (distance.y == 0 || distance.y > 0):
				hit()
			else:
				die()
		
func hit():
	get_node("../Player").get_hit()
	hit = true

func check_death():
	if (position.y > 250):
		queue_free()

func die():
	$CollisionShape2D.queue_free()
	dead = true
