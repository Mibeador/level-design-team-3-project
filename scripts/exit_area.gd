extends Area2D

var level: Node2D

func _ready() -> void:
	level = get_tree().get_first_node_in_group("level")

func _on_body_entered(body: Node2D) -> void:
	level.exit_area()
