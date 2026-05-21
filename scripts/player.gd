extends CharacterBody2D

##Base movement speed
@export var move_speed = 20.0

var direction: Vector2

func _physics_process(delta: float) -> void:
	#Y axis values for player input
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
	else:
		direction.y = 0
	#X axis values for player input
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	elif Input.is_action_pressed("move_left"):
		direction.x = -1
	else:
		direction.x = 0
	direction = direction.normalized()
	velocity = direction * move_speed * delta * 200
	
	move_and_slide()
