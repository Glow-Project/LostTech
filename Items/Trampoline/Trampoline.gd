extends Area2D

export var JUMP_HEIGHT = 300

func _on_Trampoline_body_entered(body):
	if (body.name == "Player"):
		get_node("../Player").bump(JUMP_HEIGHT)
		$AnimatedSprite.play("bump")
