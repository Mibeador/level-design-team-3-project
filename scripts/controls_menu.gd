extends CanvasLayer

var player = CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _on_resume_pressed() -> void:
	player.controlsMenu()

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/temp_title.tscn")
