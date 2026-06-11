extends Node2D

@export var trigger_goal: int
var triggers_completed = 0
var level_finished = false

func trigger_activated():
	triggers_completed += 1
	print(triggers_completed)
	if triggers_completed == trigger_goal:
		triggers_complete()
	else:
		pass

func triggers_complete():
	level_finished = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !level_finished:
		print("you can't use this yet")
	else:
		get_tree().change_scene_to_file("res://scenes/victory_screen.tscn")
