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
	else:
		pass

func triggers_complete():
	level_finished = true
#exit area logic
func exit_area():
	if level_finished:
		get_tree().change_scene_to_packed(next_scene)
	elif !level_finished:
		print("you can't use this yet")
		ui.exit_area_tutorial()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if !level_finished:
		print("you can't use this yet")
	else:
		get_tree().change_scene_to_file("res://scenes/ui/victory_screen.tscn")
