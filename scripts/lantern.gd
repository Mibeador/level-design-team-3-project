extends Interactable

var player_in_vicinity: bool
var player = CharacterBody2D
@export var prompt_message = "Interact"
@export var prompt_input = "interact"
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	player_in_vicinity = false
	player = get_tree().get_first_node_in_group("player")
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
	print(prompt_message + "\n[" + key_name + "]")
	return prompt_message + "\n[" + key_name + "]"
#logic for sprite visibility
func interacted():
	if sprite_2d.visible == true:
		sprite_2d.visible = false
	elif sprite_2d.visible == false:
		sprite_2d.visible = true
