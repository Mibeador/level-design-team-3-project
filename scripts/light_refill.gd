extends Area2D
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var fuel = CanvasLayer

func _ready() -> void:
	fuel = get_tree().get_first_node_in_group("fuel")

func _on_body_entered(body: Node2D) -> void:
	#print("entered")
	tile_map_layer.visible = false
	collision_shape_2d.queue_free()
	fuel.refill()
	$PickUpOil.play()
