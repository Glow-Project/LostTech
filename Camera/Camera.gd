extends Camera2D

func _process(_delta):
	var player = get_node_or_null("../Player")
	if (!is_instance_valid(player)): return
	position.x = player.position.x
	if (player.position.y < -10):
		position.y = -80
	else:
		position.y = 80
