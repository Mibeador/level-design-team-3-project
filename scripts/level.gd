extends Node2D

@onready var tutorial_enemy_spawn: Marker2D = $TutorialEnemySpawn
@onready var enemy_spawn_trigger: Area2D = $EnemySpawnTrigger


## How many torches need to be lit to complete the level?
@export var trigger_goal: int
## Does the player start with the lantern?
@export var lantern_to_start: bool
## What is the next scene that the player will play?
@export var next_scene: PackedScene
## Enemy scene (only needed on tutorial level)
@export var enemy: PackedScene
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

func initialize():
	if lantern_to_start:
		player.lantern_start()
	elif !lantern_to_start:
		player.no_lantern_start()
	if tutorial:
		player.tutorial_level()
		fuel.tutorial_level()
	death_screen.hide()
	triggers_completed = 0
	#start engine time scale (allows game to be played) NEEDED if engine time scale was reset upon prev death
	Engine.time_scale = 1

func trigger_activated():
	if tutorial:
		ui.trigger_light_tutorial()
	triggers_completed += 1
	if triggers_completed == trigger_goal:
		triggers_complete()
		$GoalComplete.play()


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
	

func _on_enemy_spawn_trigger_body_entered(body: Node2D) -> void:
	if player.tut_lantern():
		var instance = enemy.instantiate()
		instance.global_position = tutorial_enemy_spawn.global_position
		add_child(instance)
		ui.enemy_tutorial()
		enemy_spawn_trigger.queue_free()
	
