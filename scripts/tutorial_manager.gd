extends Node2D

var player: CharacterBody2D
var ui: CanvasLayer
var enemy: CharacterBody2D
var lantern_tut = false
var enemy_tut = false
var stun_tut = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	ui = get_tree().get_first_node_in_group("ui")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("light_toggle") && ui.is_tutorial():
		if lantern_tut:
			ui.finish_lantern_tutorial()
			lantern_tut = false
		if enemy_tut:
			ui.finish_enemy_tutorial()
			enemy_tut = false
		if stun_tut:
			ui.finish_stun_tutorial()
			stun_tut = false
			print("input to finish stun tut")

func lantern_tutorial():
	if ui.is_tutorial():
		lantern_tut = true
		player.set_process_mode(Node.PROCESS_MODE_DISABLED)

func enemy_tutorial():
	if ui.is_tutorial():
		enemy = get_tree().get_first_node_in_group("enemy")
		enemy_tut = true
		player.set_process_mode(Node.PROCESS_MODE_DISABLED)
		enemy.set_process_mode(Node.PROCESS_MODE_DISABLED)

func stun_tutorial():
	if ui.is_tutorial():
		stun_tut = true
		player.set_process_mode(Node.PROCESS_MODE_DISABLED)
		enemy.set_process_mode(Node.PROCESS_MODE_DISABLED)
		print("stun tutorial")
