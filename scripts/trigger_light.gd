extends Area2D
@onready var point_light_2d: PointLight2D = $PointLight2D


func _on_body_entered(body: Node2D) -> void:
	point_light_2d.visible = true
