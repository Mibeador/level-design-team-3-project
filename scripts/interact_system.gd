extends CollisionObject2D
class_name Interactable

@onready var prompt: Label = %Prompt

@export var prompt_message = "Interact"
@export var prompt_input = "interact"
var parent = StaticBody2D

func _ready() -> void:
	parent = get_parent()

func _physics_process(delta: float) -> void:
	if prompt != null:
		prompt.text = ""
	else:
		pass

#logic to tell interactable item player is in vicinity
func _on_body_entered(body: Node2D) -> void:
	parent.can_interact()
	
#logic to tell interactable item player is not in vicinity
func _on_body_exited(body: Node2D) -> void:
	parent.cannot_interact()
