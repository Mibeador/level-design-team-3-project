extends CenterContainer

@onready var settings_menu = $"../SettingsMenu"
@onready var ls_menu = $"../LevelSelectMenu"

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/animated_scenes/opening_scene_transition.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_level_select_pressed() -> void:
	ls_menu.show()

func _on_settings_pressed() -> void:
	settings_menu.show()
	
