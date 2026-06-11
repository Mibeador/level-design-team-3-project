extends Area2D
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var trigger_light: Area2D = $"."

var level = Node2D
var player = CharacterBody2D
var player_in_area = false

func _ready() -> void:
	point_light_2d.visible = false
	level = get_tree().get_first_node_in_group("level")
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player_in_area && player.light_on:
		collision_shape_2d.queue_free()
		point_light_2d.visible = true
		level.trigger_activated()
	else:
		pass

func _on_body_entered(body: Node2D) -> void:
	if !player.light_on:
		player_in_area = true
	elif player.light_on:
		collision_shape_2d.queue_free()
		point_light_2d.visible = true
		level.trigger_activated()

func _on_body_exited(body: Node2D) -> void:
	player_in_area = false
