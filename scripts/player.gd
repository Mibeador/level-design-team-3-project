extends CharacterBody2D
class_name Player

@onready var lantern_light: PointLight2D = $LanternLight
@onready var light_timer: Timer = $LanternLight/LightTimer
@onready var light_animation: AnimationPlayer = $LanternLight/LightAnimation
@onready var character_light: PointLight2D = $CharacterLight

##Base movement speed
@export var move_speed = 20.0

static var instance: Player
var direction: Vector2
var light_on = true
var light_cooled_down = true

func _ready() -> void:
	instance = self
	

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
	
	#Light logic
	if Input.is_action_just_pressed("light_toggle") && light_cooled_down:
		if light_on:
			light_animation.play("light_off")
			light_timer.start()
			light_cooled_down = false
			light_on = false
			character_light.visible = true
		elif !light_on:
			light_animation.play("light_on")
			light_timer.start()
			light_cooled_down = false
			light_on = true
			character_light.visible = false
	
	is_light_on()
	move_and_slide()
#Logic to send light info to enemy
func is_light_on() -> bool:
	if light_on:
		return true
	else:
		return false
#cooldown logic
func _on_light_timer_timeout() -> void:
	light_cooled_down = true

#dark area logic (still needs animations)
func dark_area():
	lantern_light.visible = false
	character_light.visible = true

func dark_area_exited():
	lantern_light.visible = true
	character_light.visible = false
