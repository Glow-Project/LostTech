extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("idle")

func _on_Cassette_body_entered(body):
	if (body.name == "Player"):
		get_node("../Player").collected_cassets.append("Classic")
		queue_free()

