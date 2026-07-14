extends Node2D

@onready var text1: TypeWriterLabel = $StoryText1


func _on_story_text_1_typewriting_done() -> void:
	pass
	

func cutscene1():
	await get_tree().create_timer(3.0).timeout
	text1.typewrite("I would do anything...")
	await _on_story_text_1_typewriting_done()
	text1.typewrite("To see her again...")
