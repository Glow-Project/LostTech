extends Particles2D

func _process(_delta):
	position.x = get_parent().get_node("Camera").position.x + 150
	position.y = get_parent().get_node("Camera").position.y - 100
