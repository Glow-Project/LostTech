extends Camera2D

func _process(_delta):
	var player = get_node_or_null("../Player")
	if (is_instance_valid(player)):
		position.x = player.position.x
