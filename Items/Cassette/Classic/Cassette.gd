extends Area2D

func _ready():
	$AnimationPlayer.play("idle")

func _on_Cassette_body_entered(body):
	if (body.name == "Player"):
		queue_free()
		body.load_battery(100 - body.battery_level)
		SaveData.collected_casettes.append(name)

