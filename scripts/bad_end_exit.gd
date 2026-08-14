extends Area2D

@onready var player: Player = $"../Playable/Player"
@onready var fade_anim: AnimationPlayer = $"../ColorRect2/FadeControl"

func _on_body_entered(body: Node2D) -> void:
	fade_anim.play_backwards("fade_in")
	player.global_position = Vector2(233,-381)
	player.set_process(false)
	player.set_physics_process(false)
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://scenes/animated_scenes/bad_end.tscn")
