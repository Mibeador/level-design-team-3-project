extends Area2D
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var fuel = CanvasLayer
var player = CharacterBody2D

func _ready() -> void:
	fuel = get_tree().get_first_node_in_group("fuel")
	player = get_tree().get_first_node_in_group("player")

func _on_body_entered(body: Node2D) -> void:
	if player.tut_lantern():
		tile_map_layer.visible = false
		collision_shape_2d.queue_free()
		fuel.refill()
		$PickUpOil.play()
