extends Interactable

var player_in_vicinity: bool

func _ready() -> void:
	player_in_vicinity = false

func can_interact():
	player_in_vicinity = true
	

func cannot_interact():
	player_in_vicinity = false
	
