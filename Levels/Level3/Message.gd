extends Label

var activated = false

func _process(delta):
	print(visible_characters)
	if activated:
		visible_characters += 5*delta


func _on_WriteMessage_body_entered(body):
	if body.name == "Player":
		activated = true
