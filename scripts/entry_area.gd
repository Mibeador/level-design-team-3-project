extends Area2D

var ui: CanvasLayer

func _ready() -> void:
	ui = get_tree().get_first_node_in_group("ui")

func _on_body_entered(body: Node2D) -> void:
	ui.entry_area()
