extends CanvasLayer

@onready var death_screen_audio: AudioStreamPlayer = $"Death Screen Audio"


func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/temp_title.tscn")
#Play the audio only when death screen is showing
func activate():
	death_screen_audio.play()
