extends Node2D

@onready var open_anim: AnimationPlayer = $OpenAnim
@onready var text1: TypeWriterLabel = $CanvasLayer/StoryText1
@onready var heartbeat: AudioStreamPlayer = $Heartbeat
@onready var anim2: AnimationPlayer = $CanvasLayer/StoryText1/AnimationPlayer
@onready var anim1: AnimationPlayer = $AnimatedSprite2D/LanternLight/AnimationPlayer

func _physics_process(delta: float) -> void:
	cutscene_skip()

func _ready() -> void:
	heartbeat.pitch_scale = 0.8
	heartbeat.play()
	open_anim.play("opening_scene_intro")
	open_anim.play("Scene Transition")
	await get_tree().create_timer(11).timeout
	text1.typewrite("I would do anything...")
	await get_tree().create_timer(5).timeout
	text1.typewrite("To see her again...")
	await get_tree().create_timer(5).timeout
	anim1.play("light_fade")
	await get_tree().create_timer(3).timeout
	anim2.play("text_fade")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/levels/final_game/tutorial_level.tscn")

func cutscene_skip():
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/levels/final_game/tutorial_level.tscn")
