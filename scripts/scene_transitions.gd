extends Node2D

@onready var text1: TypeWriterLabel = $CanvasLayer/StoryText1
@onready var anim1: AnimationPlayer = $AnimatedSprite2D/LanternLight/AnimationPlayer
@onready var anim2: AnimationPlayer = $CanvasLayer/StoryText1/AnimationPlayer
@onready var step_timer: Timer = $PlayerStep/StepTimer
@onready var player_step: AudioStreamPlayer2D = $PlayerStep


func _ready() -> void:
	if Globals.current_level==1:
		cutscene1()
	if Globals.current_level==2:
		cutscene2()
	if Globals.current_level==3:
		cutscene3()
	#if Globals.current_level==4:
		#cutscene4()

func _physics_process(delta: float) -> void:
	cutscene_walk()

func cutscene1():
	await get_tree().create_timer(3).timeout
	text1.typewrite("I promised I would never leave her...")
	await get_tree().create_timer(7).timeout
	text1.typewrite("Her voice echoes in my head...")
	await get_tree().create_timer(7).timeout
	text1.typewrite("I have to find her...")
	await get_tree().create_timer(7).timeout
	anim1.play("light_fade")
	await get_tree().create_timer(3).timeout
	anim2.play("text_fade")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/levels/playtest_2/playtest_level_v2.tscn")


func cutscene2():
	await get_tree().create_timer(3).timeout
	text1.typewrite("I can't leave her behind...")
	await get_tree().create_timer(7).timeout
	text1.typewrite("Not for anyone...")
	await get_tree().create_timer(7).timeout
	text1.typewrite("Even our child...")
	await get_tree().create_timer(7).timeout
	anim1.play("light_fade")
	await get_tree().create_timer(3).timeout
	anim2.play("text_fade")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/levels/playtest_2/tutorial_level.tscn")

func cutscene3():
	await get_tree().create_timer(3).timeout
	text1.typewrite("She told me...")
	await get_tree().create_timer(7).timeout
	text1.typewrite("To take care of them...")
	await get_tree().create_timer(7).timeout
	text1.typewrite("But I can't without her...")
	await get_tree().create_timer(7).timeout
	anim1.play("light_fade")
	await get_tree().create_timer(3).timeout
	anim2.play("text_fade")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/levels/playtest_2/tutorial_level.tscn")

func cutscene4():
	pass
	
func cutscene_walk():
	if step_timer.is_stopped():
		step_timer.start()
		player_step.play()
	else:
		pass
