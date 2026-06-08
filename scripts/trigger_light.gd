extends Area2D
@onready var point_light_2d: PointLight2D = $PointLight2D

var level = Node2D
var player = CharacterBody2D

func _ready() -> void:
	point_light_2d.visible = false
	level = get_tree().get_first_node_in_group("level")
	player = get_tree().get_first_node_in_group("player")

func _on_body_entered(body: Node2D) -> void:
	if !player.light_on:
		return
	elif player.light_on:
		point_light_2d.visible = true
		level.trigger_activated()
