extends CanvasLayer

@onready var fuel_bar: ProgressBar = $FuelBar
@onready var fuel_timer: Timer = $FuelTimer
var player: CharacterBody2D
var has_fuel: bool
var tutorial: bool = false
var ui

func _ready():
	has_fuel = true
	#synch fuel bar to timer
	fuel_bar.max_value = fuel_timer.time_left
	fuel_bar.value = fuel_timer.time_left
	player = get_tree().get_first_node_in_group("player")
	ui = get_tree().get_first_node_in_group("ui")
#fuel timer logic
func _process(delta: float) -> void:
	if !fuel_timer.is_stopped():
		fuel_bar.value = fuel_timer.time_left
	if !player.is_light_on():
		fuel_timer.paused = true
	if player.is_light_on():
		fuel_timer.paused = false
	fuel_level()
#refill fuel upon fuel pickup
func refill():
	fuel_timer.start()
	if tutorial:
		ui.fuel_tutorial()
#send to player if have fuel
func fuel_level():
	if fuel_timer.time_left >= 0.1:
		has_fuel = true
func _on_fuel_timer_timeout() -> void:
	has_fuel = false
	player.out_of_fuel()
func tutorial_level():
	tutorial = true
