extends Node2D

@onready var text1: TypeWriterLabel = $CanvasLayer/StoryText1
@onready var anim1: AnimationPlayer = $AnimatedSprite2D/LanternLight/AnimationPlayer
@onready var anim2: AnimationPlayer = $CanvasLayer/StoryText1/AnimationPlayer



func _ready() -> void:
	if Globals.current_level==1:
		cutscene1()
	#if Globals.current_level==2:
		#cutscene2()
	#if Globals.current_level==3:
		#cutscene3()
	#if Globals.current_level==4:
		#cutscene4()

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
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/levels/playtest_2/tutorial_level.tscn")
	
