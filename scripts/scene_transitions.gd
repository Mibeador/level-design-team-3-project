extends Node2D

@onready var text1: TypeWriterLabel = $CanvasLayer/StoryText1
@onready var anim1: AnimationPlayer = $AnimatedSprite2D/LanternLight/AnimationPlayer
@onready var anim2: AnimationPlayer = $CanvasLayer/StoryText1/AnimationPlayer
@onready var step_timer: Timer = $PlayerStep/StepTimer
@onready var player_step: AudioStreamPlayer2D = $PlayerStep
@onready var spook_sound: AudioStreamPlayer2D = $MonsterDespawn
@onready var heartbeat: AudioStreamPlayer = $Heartbeat

var next_scene = PackedScene
@export var scene_0 = PackedScene
@export var scene_1 = PackedScene
@export var scene_2 = PackedScene
@export var scene_3 = PackedScene
@export var scene_4 = PackedScene

func _ready() -> void:
	if Globals.current_level==1:
		next_scene = scene_1
		cutscene1()
	if Globals.current_level==2:
		next_scene = scene_2
		cutscene2()
	if Globals.current_level==3:
		next_scene = scene_3
		cutscene3()
	#if Globals.current_level==4:
		#cutscene4()
		

func _physics_process(delta: float) -> void:
	cutscene_skip()

func cutscene1():
	heartbeat.pitch_scale = 1.0
	heartbeat.play()
	await get_tree().create_timer(3).timeout
	text1.typewrite("I promised I would never leave her...")
	await get_tree().create_timer(7).timeout
	text1.typewrite("Her voice echoes in my head...")
	await get_tree().create_timer(6).timeout
	text1.typewrite("I have to find her...")
	await get_tree().create_timer(6).timeout
	anim1.play("light_fade")
	await get_tree().create_timer(3).timeout
	anim2.play("text_fade")
	spook_sound.play()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_packed(next_scene)


func cutscene2():
	heartbeat.pitch_scale = 1.33
	heartbeat.play()
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
	get_tree().change_scene_to_packed(next_scene)

func cutscene3():
	heartbeat.pitch_scale = 1.5
	heartbeat.play()
	await get_tree().create_timer(3).timeout
	text1.typewrite("She told me...")
	await get_tree().create_timer(7).timeout
	text1.typewrite("To take care of them...")
	await get_tree().create_timer(7).timeout
	text1.typewrite("But I'm nothing without her...")
	await get_tree().create_timer(7).timeout
	anim1.play("light_fade")
	await get_tree().create_timer(3).timeout
	anim2.play("text_fade")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_packed(next_scene)

func cutscene4():
	pass
	
func cutscene_walk():
	if step_timer.is_stopped():
		step_timer.start()
		player_step.play()
	else:
		pass

func cutscene_skip():
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_packed(next_scene)
