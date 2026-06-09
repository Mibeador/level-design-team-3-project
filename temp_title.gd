extends CenterContainer



func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/playtest_level.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_level_select_pressed() -> void:
	pass # Replace with function body.

func _on_settings_pressed() -> void:
	pass # Replace with function body.
