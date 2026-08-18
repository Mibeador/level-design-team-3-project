extends CanvasLayer

@onready var tutorial: Label = $Tutorial
@onready var health: Label = $Health
@onready var dark_area_timer: Timer = $DarkAreaTimer
@onready var trigger_light_timer: Timer = $TriggerLightTimer
@onready var fuel_tutorial_timer: Timer = $FuelTutorialTimer
@onready var lantern_timer: Timer = $LanternTimer
@onready var health_sprites: Sprite2D = $HealthSprites
@onready var animation_player: AnimationPlayer = $HealthSprites/AnimationPlayer

var player_health = 4
var player = CharacterBody2D
var game_manager = Node2D
var enemy = CharacterBody2D
var tutorial_in_progress = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	game_manager = get_tree().get_first_node_in_group("game manager")
	reset_shader()

func reset_shader():
	var mat = health_sprites.material
	if mat == ShaderMaterial:
		mat.set_shader_paramater("flash_pct", 0.0)

#health logic
func _physics_process(delta: float) -> void:
	health.text = "Health: " + str(player_health)
	if player_health == 4:
		health_sprites.frame = 0
	if player_health == 3:
		health_sprites.frame = 1
	if player_health == 2:
		health_sprites.frame = 2
	if player_health == 1:
		health_sprites.frame = 3
	if player_health == 0:
		health_sprites.frame = 4
#health logic, paired with physics process
func player_attacked():
	animation_player.play("hearts_anim")
	player_health -= 1
#dark area tutorial
func dark_area_tutorial():
	trigger_light_timer.stop()
	dark_area_timer.stop()
	fuel_tutorial_timer.stop()
	lantern_timer.stop()
	tutorial.text = "Some areas affect your light. \n Tread carefully."
	dark_area_timer.start(5.0)
	await dark_area_timer.timeout
	tutorial.text = ""
#exit area tutorial
func exit_area_tutorial():
	dark_area_timer.stop()
	trigger_light_timer.stop()
	fuel_tutorial_timer.stop()
	lantern_timer.stop()
	tutorial.text = "You can't use this yet."
	await get_tree().create_timer(5.0).timeout
	tutorial.text = ""
#entry area text
func entry_area():
	dark_area_timer.stop()
	trigger_light_timer.stop()
	fuel_tutorial_timer.stop()
	lantern_timer.stop()
	tutorial.text = "There is no turning back."
	await get_tree().create_timer(5.0).timeout
	tutorial.text = ""
#trigger light tutorial
func trigger_light_tutorial():
	dark_area_timer.stop()
	trigger_light_timer.stop()
	fuel_tutorial_timer.stop()
	lantern_timer.stop()
	tutorial.text = "Light all the torches \n to unlock the next level."
	trigger_light_timer.start(5.0)
	await trigger_light_timer.timeout
	tutorial.text = ""
func fuel_tutorial():
	dark_area_timer.stop()
	trigger_light_timer.stop()
	fuel_tutorial_timer.stop()
	lantern_timer.stop()
	tutorial.text = "Collect fuel to refill your lantern. \n Use them wisely."
	fuel_tutorial_timer.start(5.0)
	await fuel_tutorial_timer.timeout
	tutorial.text = ""
func lantern_tutorial():
	dark_area_timer.stop()
	trigger_light_timer.stop()
	fuel_tutorial_timer.stop()
	tutorial_in_progress = true
	tutorial.text = "Press F to light or put out \n your lantern.\n Use your lantern to light torches."
	game_manager.lantern_tutorial()
func finish_lantern_tutorial():
	player.set_process_mode(Node.PROCESS_MODE_INHERIT)
	await get_tree().physics_frame
	player.lantern_tutorial_completed()
	player.light_animation.play("light_on")
	player.light_on = true
	tutorial.text = ""
	tutorial_in_progress = false
func enemy_tutorial():
	dark_area_timer.stop()
	trigger_light_timer.stop()
	fuel_tutorial_timer.stop()
	tutorial_in_progress = true
	tutorial.text = "The monster is attracted \n to your light. It can see you \n from farther away when it is on. \n Press F to put out your lantern."
	game_manager.enemy_tutorial()
func finish_enemy_tutorial():
	enemy = get_tree().get_first_node_in_group("enemy")
	player.set_process_mode(Node.PROCESS_MODE_INHERIT)
	enemy.set_process_mode(Node.PROCESS_MODE_INHERIT)
	await get_tree().physics_frame
	player.light_animation.play("light_off")
	player.light_on = false
	tutorial.text = ""
	enemy.stun_tutorial()
	tutorial_in_progress = false
func stun_tutorial():
	dark_area_timer.stop()
	trigger_light_timer.stop()
	fuel_tutorial_timer.stop()
	tutorial_in_progress = true
	tutorial.text = "Press F to light your lantern \n and stun the monster."
	game_manager.stun_tutorial()
func finish_stun_tutorial():
	player.set_process_mode(Node.PROCESS_MODE_INHERIT)
	enemy.set_process_mode(Node.PROCESS_MODE_INHERIT)
	await get_tree().physics_frame
	player.light_animation.play("light_on")
	player.light_on = true
	tutorial.text = ""
	enemy.stun()
	tutorial_in_progress = false
func is_tutorial():
	return tutorial_in_progress
