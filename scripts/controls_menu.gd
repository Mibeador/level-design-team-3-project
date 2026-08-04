extends CanvasLayer
@onready var settings_menu: Control = $SettingsMenu
@onready var margin_container: MarginContainer = $MarginContainer
@onready var controls_menu: CanvasLayer = $"."

var player = CharacterBody2D
var ui = CanvasLayer
var fuel = CanvasLayer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	ui = get_tree().get_first_node_in_group("ui")
	fuel = get_tree().get_first_node_in_group("fuel")

func _physics_process(delta: float) -> void:
	if settings_menu.visible == true:
		margin_container.visible = false
	elif settings_menu.visible == false:
		margin_container.visible = true
	if controls_menu.visible == true:
		ui.hide()
		fuel.hide()
	elif controls_menu.visible == false:
		ui.show()
		fuel.show()

func _on_resume_pressed() -> void:
	player.controlsMenu()

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/temp_title.tscn")


func _on_button_pressed() -> void:
	settings_menu.show()

	
