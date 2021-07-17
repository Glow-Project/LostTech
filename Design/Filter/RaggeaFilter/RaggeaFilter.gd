extends Node2D

export var rotation_speed = 0.2

func _process(delta):
	rotate(rotation_speed*delta)
