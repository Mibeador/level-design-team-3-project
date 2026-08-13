extends Control

func _ready() -> void:
	await get_tree().create_timer(31).timeout
	get_tree().change_scene_to_file("res://scenes/ui/temp_title.tscn")
