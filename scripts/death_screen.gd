extends Control



func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/playtest_2/playtest_level_v2.tscn")


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/temp_title.tscn")
