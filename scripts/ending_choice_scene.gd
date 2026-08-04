extends Node2D

@onready var open_anim: AnimationPlayer = $OpenAnim
@onready var text1: TypeWriterLabel = $CanvasLayer/StoryText1
@onready var heartbeat: AudioStreamPlayer = $Heartbeat
@onready var text_anim: AnimationPlayer = $CanvasLayer/StoryText1/AnimationPlayer
@onready var light_anim: AnimationPlayer = $AnimatedSprite2D/LanternLight/AnimationPlayer
@onready var cam_anim: AnimationPlayer = $CamAnim
@onready var jim: AnimatedSprite2D = $PlayerCuts
@onready var lover_anim: AnimationPlayer = $Lover/AnimationPlayer
@onready var player_sprite: Player = $Playable/Player
@onready var cut_cam: Camera2D = $PlayerCuts/Camera2D2
@onready var player_ui1: CanvasLayer = $Playable/Player/UI
@onready var player_ui2: CanvasLayer = $Playable/Player/FuelUI
@onready var choice_song: AudioStreamPlayer = $ChoiceSong
@onready var end_cam: Camera2D = $Playable/Player/EndCam

## How many torches need to be lit to complete the level?
@export var trigger_goal: int
## Does the player start with the lantern?
@export var lantern_to_start: bool
## What is the next scene that the player will play?
@export var next_scene: PackedScene
## Is this the tutorial level?
@export var tutorial: bool
## What level is this? (Tutorial is 0)
@export var current_level: int
var triggers_completed = 0
var level_finished = false
var player: CharacterBody2D
var ui
var fuel
var death_screen = Node2D


func _ready() -> void:
	fuel = get_tree().get_first_node_in_group("fuel")
	ui = get_tree().get_first_node_in_group("ui")
	player = get_tree().get_first_node_in_group("player")
	death_screen = get_tree().get_first_node_in_group("death screen")
	initialize()
	cutscene1()

func initialize():
	if lantern_to_start:
		player.lantern_start()
	elif !lantern_to_start:
		player.no_lantern_start()
	if tutorial:
		player.tutorial_level()
		fuel.tutorial_level()
	death_screen.hide()
	#start engine time scale (allows game to be played) NEEDED if engine time scale was reset upon prev death
	Engine.time_scale = 1

func trigger_activated():
	if tutorial:
		ui.trigger_light_tutorial()
	triggers_completed += 1
	if triggers_completed == trigger_goal:
		triggers_complete()
		$GoalComplete.play()
	else:
		pass

func triggers_complete():
	level_finished = true
#exit area logic
func exit_area():
	if level_finished:
		Globals.current_level = current_level + 1
		get_tree().change_scene_to_file("res://scenes/animated_scenes/scene_transitions.tscn")
	elif !level_finished:
		ui.exit_area_tutorial()
		
func player_died():
	death_screen.show()
	#custom function to start death screen audio
	death_screen.activate()
	#stop gameplay while death screen is showing
	Engine.time_scale = 0
	


func cutscene1():
	heartbeat.pitch_scale = 0.8
	heartbeat.play()
	await get_tree().create_timer(5).timeout
	text1.typewrite("How long has it been...")
	await get_tree().create_timer(5).timeout
	text1.typewrite("I just want...")
	await get_tree().create_timer(5).timeout
	text1.typewrite("To see her one more time...")
	await get_tree().create_timer(4.9).timeout
	heartbeat.stop()
	text_anim.play("text_fade")
	open_anim.play("light_up")
	jim.play("stopped")
	await get_tree().create_timer(5).timeout
	choice_song.play()
	cam_anim.play("pan_to_lover")
	await get_tree().create_timer(3).timeout
	lover_anim.play("walk_across")
	await get_tree().create_timer(5).timeout
	cam_anim.play_backwards("pan_to_lover")
	jim.play("trans_ready")
	await get_tree().create_timer(5).timeout
	jim.hide()
	player_sprite.show()
	cut_cam.enabled = false
	player.global_position = Vector2(0,0)
	end_cam.global_position = Vector2(0,0)
	player_ui1.show()
	player_ui2.show()
	
