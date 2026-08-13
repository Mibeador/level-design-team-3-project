extends Node2D

@onready var text1: TypeWriterLabel = $CanvasLayer/StoryText1
@onready var step_timer: Timer = $PlayerStep/StepTimer
@onready var player_anim: AnimationPlayer = $PlayerSprite/PlayerAnim
@onready var shadow_anim: AnimationPlayer = $ShadowMan/ShadowAnim
@onready var player_step: AudioStreamPlayer2D = $PlayerStep
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var text_anim: AnimationPlayer = $CanvasLayer/StoryText1/TextAnim
@onready var lantern_anim: AnimationPlayer = $PlayerSprite/LanternLight/AnimationPlayer


func _ready() -> void:
	cutscene_walk()
	await get_tree().create_timer(1).timeout
	text1.typewrite("I cannot...")
	


func cutscene_walk():
	if step_timer.is_stopped():
		step_timer.start()


func _on_step_timer_timeout() -> void:
	player_step.play()
