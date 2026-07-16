extends Node2D

## How many torches need to be lit to complete the level?
@export var trigger_goal: int
## Does the player start with the lantern?
@export var lantern_to_start: bool
## What is the next scene that the player will play?
@export var next_scene: PackedScene
## Is this the tutorial level?
@export var tutorial: bool
var triggers_completed = 0
var level_finished = false
var player: CharacterBody2D
var ui
var fuel


func _ready() -> void:
	fuel = get_tree().get_first_node_in_group("fuel")
	ui = get_tree().get_first_node_in_group("ui")
	player = get_tree().get_first_node_in_group("player")
	initialize()

func initialize():
	if lantern_to_start:
		player.lantern_start()
	elif !lantern_to_start:
		player.no_lantern_start()
	if tutorial:
		player.tutorial_level()
		fuel.tutorial_level()

func trigger_activated():
	if tutorial:
		ui.trigger_light_tutorial()
	triggers_completed += 1
	print(triggers_completed)
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
		Globals.current_level += 1
		print(Globals.current_level)
		get_tree().change_scene_to_file("res://scenes/animated_scenes/scene_transitions.tscn")
	elif !level_finished:
		print("you can't use this yet")
		ui.exit_area_tutorial()
