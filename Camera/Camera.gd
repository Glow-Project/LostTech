extends Camera2D

func _process(_delta):
	position.x = get_node("../Player").position.x
