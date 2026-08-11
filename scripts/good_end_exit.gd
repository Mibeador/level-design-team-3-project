extends Area2D

@onready var white_anim: AnimationPlayer = $"../ColorRect/WhiteControl"
@onready var player: Player = $"../Playable/Player"


func _on_body_entered(body: Node2D) -> void:
	white_anim.play("white_out")
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://scenes/animated_scenes/good_end.tscn")
