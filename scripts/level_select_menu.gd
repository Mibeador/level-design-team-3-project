extends Control

@export var level0: PackedScene
@export var level1: PackedScene
@export var level2: PackedScene
@export var level3: PackedScene
@export var level4: PackedScene

func _on_exit_pressed() -> void:
	hide()


func _on_level_0_pressed() -> void:
	get_tree().change_scene_to_packed(level0)


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_packed(level1)


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_packed(level2)


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_packed(level3)


func _on_level_4_pressed() -> void:
	get_tree().change_scene_to_packed(level4)
