extends Camera2D

func _process(delta):
	position.x = get_node("../Player").position.x
