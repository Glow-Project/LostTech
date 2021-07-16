extends Area2D

func _ready():
	$AnimationPlayer.play("idle")

func _on_Cassette_body_entered(body):
	if (body.name == "Player"):
		SaveData.collected_casettes.append(name)
		queue_free()

