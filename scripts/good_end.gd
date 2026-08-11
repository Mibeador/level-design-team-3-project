extends Node2D

@onready var text1: TypeWriterLabel = $CanvasLayer/StoryText1
@onready var cam_anim: AnimationPlayer = $Camera2D2/CameraAnim
@onready var player_anim: AnimationPlayer = $PlayerSprite/PlayerAnim
@onready var white_anim: AnimationPlayer = $ColorRect/WhiteControl
@onready var player_step: AudioStreamPlayer2D = $PlayerStep
@onready var step_timer: Timer = $PlayerStep/StepTimer
@onready var text_anim: AnimationPlayer = $CanvasLayer/StoryText1/TextAnim

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	cutscene_walk()
	player_anim.play("walk from cave")
	await get_tree().create_timer(3.5).timeout
	step_timer.stop()
	await get_tree().create_timer(1.5).timeout
	cam_anim.play("camera_pan")
	await get_tree().create_timer(5).timeout
	cam_anim.play_backwards("camera_pan")
	await get_tree().create_timer(4).timeout
	text1.typewrite("Even if it hurts...")
	await get_tree().create_timer(1).timeout
	player_anim.play("walk_off_screen")
	await get_tree().create_timer(1).timeout
	cutscene_walk()
	await get_tree().create_timer(2).timeout
	text1.typewrite("There are still people who need me...")
	await get_tree().create_timer(2).timeout
	white_anim.play("white_out")
	await get_tree().create_timer(2).timeout
	step_timer.stop()
	text_anim.play("text_fade")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/ui/good_credits.tscn")


func cutscene_walk():
	if step_timer.is_stopped():
		step_timer.start()
		


func _on_step_timer_timeout() -> void:
	player_step.play()
