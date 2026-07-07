extends Control

@export var level0: PackedScene


func _on_exit_pressed() -> void:
	hide()


func _on_level_0_pressed() -> void:
	get_tree().change_scene_to_packed(level0)
