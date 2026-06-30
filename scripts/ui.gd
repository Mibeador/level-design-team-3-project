extends CanvasLayer

@onready var tutorial: Label = $Tutorial
@onready var health: Label = $Health
var player_health = 4
var player = CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

#health logic
func _physics_process(delta: float) -> void:
	health.text = "Health: " + str(player_health)
func player_attacked():
	player_health -= 1
#dark area tutorial
func dark_area_tutorial():
	tutorial.text = "Some areas affect your light. \n Tread carefully."
	await get_tree().create_timer(5.0).timeout
	tutorial.text = ""
#exit area tutorial
func exit_area_tutorial():
	tutorial.text = "You can't use this yet"
	await get_tree().create_timer(5.0).timeout
	tutorial.text = ""
#trigger light tutorial
func trigger_light_tutorial():
	tutorial.text = "Light all the torches \n to unlock the next level"
	await get_tree().create_timer(5.0).timeout
	tutorial.text = ""
