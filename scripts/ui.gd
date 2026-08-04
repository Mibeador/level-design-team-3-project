extends CanvasLayer

@onready var tutorial: Label = $Tutorial
@onready var health: Label = $Health
@onready var dark_area_timer: Timer = $DarkAreaTimer
@onready var trigger_light_timer: Timer = $TriggerLightTimer
@onready var fuel_tutorial_timer: Timer = $FuelTutorialTimer
@onready var lantern_timer: Timer = $LanternTimer

var player_health = 4
var player = CharacterBody2D
var tutorial_in_progress = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

#health logic
func _physics_process(delta: float) -> void:
	health.text = "Health: " + str(player_health)
	if Input.is_action_just_pressed("light_toggle") && tutorial_in_progress:
		print("akshfd;lshk;dfha")
		finish_lantern_tutorial()

func player_attacked():
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
	player.set_process_mode(Node.PROCESS_MODE_DISABLED)
	tutorial_in_progress = true
	print(tutorial_in_progress)
	tutorial.text = "Press F to light or put out \n your lantern"
func finish_lantern_tutorial():
		player.set_process_mode(Node.PROCESS_MODE_INHERIT)
		print("hello")
		player.lantern_tutorial_completed()
		tutorial.text = ""
		tutorial_in_progress = false
