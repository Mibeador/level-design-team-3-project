extends Area2D
@onready var point_light_2d: PointLight2D = $PointLight2D

var level = Node2D

func _ready() -> void:
	level = get_tree().get_first_node_in_group("level")

func _on_body_entered(body: Node2D) -> void:
	point_light_2d.visible = true
	level.trigger_activated()
