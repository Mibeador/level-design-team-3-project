extends CollisionObject2D
class_name Interactable

@onready var prompt: Label = %Prompt

var parent = StaticBody2D

func _ready() -> void:
	parent = get_parent()

#logic to tell interactable item player is in vicinity
func _on_body_entered(body: Node2D) -> void:
	parent.can_interact()
	prompt.text = parent.get_prompt()
	
#logic to tell interactable item player is not in vicinity
func _on_body_exited(body: Node2D) -> void:
	parent.cannot_interact()
	prompt.text = ""
	
