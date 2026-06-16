extends CanvasLayer

@onready var fuel_bar: ProgressBar = $FuelBar
@onready var fuel_timer: Timer = $FuelTimer
var player: CharacterBody2D

func _ready():
	#synch fuel bar to timer
	fuel_bar.max_value = fuel_timer.time_left
	fuel_bar.value = fuel_timer.time_left
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if !fuel_timer.is_stopped():
		fuel_bar.value = fuel_timer.time_left
	if !player.is_light_on():
		fuel_timer.paused = true
	if player.is_light_on():
		fuel_timer.paused = false
	
