extends Interactable

var player_in_vicinity: bool
var player = CharacterBody2D
var level = Node2D
@export var prompt_message = "Interact"
@export var prompt_input = "interact"
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	player_in_vicinity = false
	player = get_tree().get_first_node_in_group("player")
	level = get_tree().get_first_node_in_group("level")
	sprite_2d.visible = false
#player is in lantern area
func can_interact():
	player_in_vicinity = true
	player.lantern_area()
#player left lantern area
func cannot_interact():
	player_in_vicinity = false
	player.lantern_area()
#logic to send prompt to interactable prompt text
func get_prompt():
	var key_name = ""
	for action in InputMap.action_get_events(prompt_input):
		if action is InputEventKey:
			key_name = action.as_text_physical_keycode()
			break
	return prompt_message + "\n[" + key_name + "]"
#logic for sprite visibility
func interacted():
	if sprite_2d.visible == true:
		sprite_2d.visible = false
		collision_shape_2d.disabled = true
		if level.final_level:
			level.animation_player.play("wall2_close")
	elif sprite_2d.visible == false:
		sprite_2d.visible = true
		collision_shape_2d.disabled = false
		if level.final_level:
			level.animation_player.play("wall2")

func yes_start():
	sprite_2d.visible = false
func no_start():
	sprite_2d.visible = true
