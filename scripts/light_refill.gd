extends Area2D

var fuel = CanvasLayer

func _ready() -> void:
	fuel = get_tree().get_first_node_in_group("fuel")

func _on_body_entered(body: Node2D) -> void:
	fuel.refill()
