extends Label

export var typing_speed: float = 0.05

var show_info = false

func _process(_delta):
	if show_info && $Timer.is_stopped():
		$Timer.start(typing_speed)

func _on_Classic_tree_exited():
	show_info = true

func _on_Timer_timeout():
	visible_characters += 1
