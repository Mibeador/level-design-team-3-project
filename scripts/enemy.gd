extends CharacterBody2D
class_name Enemy

@onready var hunger_check_timer: Timer = $HungerCheck

#Unique setup for each scene
@export_group("Scene Setup")
##Player character for the specific level
@export var player: CharacterBody2D
##Player camera for the specific level
@export var player_camera: Camera2D
##Nav agent for the specific level
@export var nav_agent: NavigationAgent2D

#enemy base settings
@export_group("Settings")
##How fast does it move in tracking state?
@export var tracking_speed = 20.0
##How fast does it move in attack state?
@export var attack_speed = 40.0
##How far is its attack range?
@export var attack_range = 1.0
##How much damage does it do per attack?
@export var attack_damage = 5.0
##How long is the cooldown between attacks?
@export var attack_cooldown = 2.0
##How far is the line of sight with the light off?
@export var light_off_sight_range = 3.0
##How far is the line of sight with the light on?
@export var light_on_sight_range = 15.0
##How long does the base stun last?
@export var stun_duration = 8.0
##How far is the range for the player to stun?
@export var stun_range = 5.0
##How high is % chance to randomly enter tracking state? (x+1/50 is the math behind hunger check. Higher assigned #, higher chance)
@export var default_hunger_stat = 1.0
##How long does it take to leave tracking state for lost state?
@export var lost_limit = 15.0
var hunting: bool = false
var current_hunger_stat = 0.0

func _ready() -> void:
	initialize()

func initialize():
	current_hunger_stat = default_hunger_stat
	hunting = false

func _physics_process(delta: float) -> void:
	pass
	

#Hunger check timer logic
func _on_hunger_check_timeout() -> void:
	if hunting:
		return
	var hunt : bool = hunger_check()
	if hunt:
		print("Tracking State")
		hunting = true
	else:
		print("Not Tracking")

#Hunger check logic
func hunger_check(chance : float = 50) -> bool:
	var _hunger_check = current_hunger_stat + 1 / chance
	var hunger = randi_range(1 , chance)
	current_hunger_stat += 1
	if hunger <= _hunger_check:
		return true
	else:
		return false
