extends Control

@onready var main = $"../../"

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value) 


func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)


func _on_button_pressed() -> void:
	hide()
