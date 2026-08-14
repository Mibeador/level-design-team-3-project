extends Node2D

@onready var text1: TypeWriterLabel = $CanvasLayer/StoryText1
@onready var step_timer: Timer = $PlayerStep/StepTimer
@onready var player_anim: AnimationPlayer = $PlayerSprite/PlayerAnim
@onready var shadow_anim: AnimationPlayer = $ShadowMan/ShadowAnim
@onready var player_step: AudioStreamPlayer2D = $PlayerStep
@onready var text_anim: AnimationPlayer = $CanvasLayer/StoryText1/TextAnim
@onready var lantern_anim: AnimationPlayer = $PlayerSprite/LanternLight/AnimationPlayer
@onready var fade_anim: AnimationPlayer = $ColorRect/FadeControl
@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var step_timer_slow: Timer = $PlayerStep/StepTimerSlow
@onready var canvas_anim: AnimationPlayer = $CanvasModulate/CanvasAnim
@onready var monster_step: AudioStreamPlayer2D = $MonsterStep
@onready var monster_step_timer: Timer = $MonsterStep/MonsterStepTimer
@onready var monster_despawn: AudioStreamPlayer2D = $MonsterDespawn


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	text1.typewrite("I cannot...")
	await get_tree().create_timer(1).timeout
	player_anim.play("walk1")
	cutscene_walk()
	await get_tree().create_timer(3).timeout
	fade_anim.play_backwards("fade_in")
	text_anim.play("text_fade")
	await get_tree().create_timer(3).timeout
	step_timer.stop()
	player_sprite.global_position = Vector2(1000,1000)
	await get_tree().create_timer(0.5).timeout
	fade_anim.play("fade_in")
	await get_tree().create_timer(2).timeout
	cutscene_walk_slow()
	player_anim.play("walk2")
	text1.typewrite("Go on...")
	text1.modulate = Color(255,255,255)
	await get_tree().create_timer(6).timeout
	step_timer_slow.stop()
	text_anim.play("text_fade")
	await get_tree().create_timer(3).timeout
	player_sprite.global_position = Vector2(1000,1000)
	await get_tree().create_timer(1).timeout
	cutscene_monster_walk()
	shadow_anim.play("walk_across")
	text1.typewrite("Without her...")
	text1.modulate = Color(160,0,0)
	await get_tree().create_timer(3.5).timeout
	fade_anim.play_backwards("fade_in")
	await get_tree().create_timer(2).timeout
	monster_despawn.play()
	await get_tree().create_timer(1).timeout
	monster_step_timer.stop()
	text_anim.play("red_fade")
	await get_tree().create_timer(5.5).timeout
	get_tree().change_scene_to_file("res://scenes/ui/bad_credits.tscn")


func cutscene_walk():
	if step_timer.is_stopped():
		step_timer.start()

func _on_step_timer_timeout() -> void:
	player_step.play()


func cutscene_walk_slow():
	if step_timer_slow.is_stopped():
		step_timer_slow.start()

func _on_step_timer_slow_timeout() -> void:
	player_step.play()

func cutscene_monster_walk():
	if monster_step_timer.is_stopped():
		monster_step_timer.start()

func _on_monster_step_timer_timeout() -> void:
	monster_step.play()
