extends Control



func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/playtest_level_v1.tscn")


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/temp_title.tscn")
