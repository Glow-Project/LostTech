extends Label

var activated = false

func _process(delta):
	if activated && text.length() != visible_characters:
		visible_characters += 75*delta


func _on_WriteMessage_body_entered(body):
	if body.name == "Player":
		activated = true
