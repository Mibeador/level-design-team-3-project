extends Control

@onready var level_0_cover: ColorRect = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Level0/level0cover
@onready var level_1_cover: ColorRect = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Level1/level1cover
@onready var level_2_cover: ColorRect = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Level2/level2cover
@onready var level_3_cover: ColorRect = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Level3/level3cover
@onready var level_4_cover: ColorRect = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Level4/level4cover

@export var level0: PackedScene
@export var level1: PackedScene
@export var level2: PackedScene
@export var level3: PackedScene
@export var level4: PackedScene
@export var level5: PackedScene

var unlocked_levels: int

func _ready() -> void:
	unlocked_levels = Globals.current_level
	unlock_levels()

func unlock_levels():
	if unlocked_levels == 0:
		level_0_cover.queue_free()
	if unlocked_levels == 1:
		level_0_cover.queue_free()
		level_1_cover.queue_free()
	if unlocked_levels == 2:
		level_0_cover.queue_free()
		level_1_cover.queue_free()
		level_2_cover.queue_free()
	if unlocked_levels == 3:
		level_0_cover.queue_free()
		level_1_cover.queue_free()
		level_2_cover.queue_free()
		level_3_cover.queue_free()
	if unlocked_levels == 4:
		level_0_cover.queue_free()
		level_1_cover.queue_free()
		level_2_cover.queue_free()
		level_3_cover.queue_free()
		level_4_cover.queue_free()
	else: pass

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


func _on_level_5_pressed() -> void:
	get_tree().change_scene_to_packed(level5)
