extends Label

var display = false
export var writing_delay = 0.05

func _process(_delta):
	if display && visible_characters != text.length() && $Timer.is_stopped():
		$Timer.start(writing_delay)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		display = true

func _on_Timer_timeout():
	visible_characters += 1
