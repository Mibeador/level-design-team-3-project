extends CanvasLayer

@onready var health: Label = $Health
var player_health = 4
var player = CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	#player_health = player.player_health
	health.text = "Health: " + str(player_health)

func player_attacked():
	player_health -= 1
