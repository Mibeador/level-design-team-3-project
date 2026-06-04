extends Node2D

@export var trigger_goal = 3
var triggers_completed = 0

func trigger_activated():
	triggers_completed += 1
	if triggers_completed == trigger_goal:
		triggers_complete()
	else:
		pass
func triggers_complete():
	print("triggers complete")
