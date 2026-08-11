extends Node2D

var player: CharacterBody2D
var ui: CanvasLayer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	ui = get_tree().get_first_node_in_group("ui")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("light_toggle") && ui.is_tutorial():
		print("akshfd;lshk;dfha")
		ui.finish_lantern_tutorial()

func lantern_tutorial():
	if ui.is_tutorial():
		player.set_process_mode(Node.PROCESS_MODE_DISABLED)
		print("this worked")
