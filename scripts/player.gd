extends CharacterBody2D
class_name Player

@onready var lantern_light: PointLight2D = $LanternLight
@onready var light_timer: Timer = $LanternLight/LightTimer
@onready var light_animation: AnimationPlayer = $LanternLight/LightAnimation
@onready var character_light: PointLight2D = $CharacterLight
@onready var attacked_animation: AnimationPlayer = $PlayerSprite/AttackedAnimation
@onready var controls_menu = $Camera2D2/ControlsMenu
@onready var player_sprite: AnimatedSprite2D = $PlayerSprite

##Base movement speed
@export var move_speed = 20.0
##How many attacks until the player dies?
@export var player_health = 4
var enemy = CharacterBody2D
static var instance: Player
var direction: Vector2
var light_on = true
var light_cooled_down = true
var enemy_stunnable = false
var in_dark_area = false
var ui = CanvasLayer
var paused = false
var light_was_on: bool
var fuel = CanvasLayer

func _ready() -> void:
	instance = self
	enemy = get_tree().get_first_node_in_group("enemy")
	ui = get_tree().get_first_node_in_group("ui")
	fuel = get_tree().get_first_node_in_group("fuel")
	

func _physics_process(delta: float) -> void:
	#Y axis values for player input
	if Input.is_action_pressed("move_up"):
		direction.y = -1
		if direction.x == 0:
			player_sprite.play("walk_up")
		direction.x = 0
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
		if direction.x == 0:
			player_sprite.play("walk_down")
		direction.x = 0
	else:
		direction.y = 0
	#Pause menu functions
	if Input.is_action_just_pressed("pause"):
		controlsMenu()
	#X axis values for player input
	if Input.is_action_pressed("move_right"):
		direction.y = 0
		direction.x = 1
		player_sprite.play("walk_right")
	elif Input.is_action_pressed("move_left"):
		direction.y = 0
		direction.x = -1
		player_sprite.play("walk_left")
	else:
		direction.x = 0
	direction = direction.normalized()
	velocity = direction * move_speed * delta * 200
	if direction.x == 0 && direction.y == 0:
		player_sprite.play("idle")
	
	#Light logic
	if Input.is_action_just_pressed("light_toggle") :
		if in_dark_area:
			return
		if light_on:
			light_animation.play("light_off")
			light_timer.start()
			light_cooled_down = false
			light_on = false
			character_light.visible = true
		elif !light_on && light_cooled_down && fuel.has_fuel:
			light_animation.play("light_on")
			light_timer.start()
			light_cooled_down = false
			light_on = true
			character_light.visible = false
			#send stun to enemy
			if enemy_stunnable:
				enemy.stun()
	
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
#ran out of fuel logic
func out_of_fuel():
	light_on = false
	light_animation.play("out_of_fuel")
#dark area logic
func dark_area():
	in_dark_area = true
	if light_on:
		light_animation.play("dark_area_enter")
		await get_tree().create_timer(1.0).timeout
		lantern_light.visible = false
		character_light.visible = true
		light_was_on = true
	else:
		light_was_on = false
		
	light_on = false
func dark_area_exited():
	in_dark_area = false
	if light_was_on:
		light_animation.play("light_on")
		lantern_light.visible = true
		character_light.visible = false
	light_on = true

#stun logic player side 
func _on_stun_area_body_entered(body: Node2D) -> void:
	enemy_stunnable = true
func _on_stun_area_body_exited(body: Node2D) -> void:
	enemy_stunnable = false

#player attacked logic
func attacked():
	ui.player_attacked()
	attacked_animation.play("attacked")
	player_health -= 1
	if player_health <=0:
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/ui/death_screen.tscn")
	
	
#pause menu logic
func controlsMenu():
	if paused:
		controls_menu.hide()
		Engine.time_scale = 1
	else:
		controls_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
