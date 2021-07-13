extends Area2D

var player_inside = false

func _ready():
	$AnimatedSprite.visible = false

func _process(_delta):
	if (Input.is_action_just_pressed("ui_accept") && player_inside):
		Global.is_paused = true
		Global.level_finished = true
		var finished_scene = load("res://GUI/Finish/Finish.tscn")
		var finished = finished_scene.instance()
		get_node("../Camera").add_child(finished)
		queue_free()

func _on_Exit_body_entered(body):
	player_inside = true
	if (body.name == "Player"):
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("idle")

func _on_Exit_body_exited(body):
	player_inside = false
	if (body.name == "Player"):
		$AnimatedSprite.visible = false
		$AnimatedSprite.stop()
