extends Node2D

export var typing_delay: float = 0.05  

var played = false
var player_inside = false
var show_info = false
var no_cassette = false

func _ready():
	if "Raggea" in SaveData.collected_casettes:
		$AnimationPlayer.queue_free()
		$TriggerRaggeaIntro.queue_free()
		$Label.queue_free()
		no_cassette = true

func _process(_delta):
	if (Input.is_action_just_pressed("ui_accept") &&
		!no_cassette &&
		$AnimationPlayer.current_animation == "Raggea Proceed"):
			$Player/Walkman/Raggea.stop()
			$AnimationPlayer.play("End Raggea")
	if (Input.is_action_just_pressed("ui_accept") &&
		player_inside):
			SaveData.lvl2_was_in_store = true
			get_tree().change_scene("res://Levels/Level2/Level2.tscn")

	if show_info && is_instance_valid($Label):
		if $Label/Timer.is_stopped():
			$Label/Timer.start(typing_delay)

func _on_TriggerRaggeaIntro_body_entered(body):
	if body.name == "Player" && !played:
		Global.is_paused = true
		$AnimationPlayer.play("Intro Raggea")
		played = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Intro Raggea":
		$Player/Walkman.stop_song()
		$Player/Walkman/Raggea.play()
		$AnimationPlayer.play("Raggea Proceed")
	elif anim_name == "End Raggea":
		Global.is_paused = false

func _on_Door_body_entered(body):
	if body.name == "Player":
		player_inside = true

func _on_Door_body_exited(body):
	if body.name == "Player":
		player_inside = false

func _on_Raggea_tree_exited():
	show_info = true

func _on_Timer_timeout():
	$Label.visible_characters += 1
