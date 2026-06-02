extends CharacterBody2D
class_name Enemy

@onready var hunger_check_timer: Timer = $HungerCheck
@onready var vision_area: Area2D = $VisionArea
@onready var light_off_vision: CollisionShape2D = $VisionArea/LightOffVision
@onready var light_on_vision: CollisionShape2D = $VisionArea/LightOnVision
@onready var vision_raycast: RayCast2D = $VisionRaycast
@onready var state_chart: StateChart = $StateChart
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var deaggro_timer: Timer = $DeaggroTimer

#Unique setup for each scene
@export_group("Scene Setup")
##Player character for the specific level
var player: CharacterBody2D
##Player camera for the specific level
var player_camera: Camera2D

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
##How fast is the flee speed?
@export var flee_speed = 15.0
##How high is % chance to randomly enter tracking state? (x+1/50 is the math behind hunger check. Higher assigned #, higher chance)
@export var default_hunger_stat = 1.0
##How long does it take to leave tracking state for lost state?
@export var lost_limit = 15.0
##Maximum distance away enemy will spawn
@export var max_spawn_dist = 250
##Minimum distance away enemy will spawn
@export var min_spawn_dist = 200

var hunting: bool = false
var current_hunger_stat = 0.0
var idle_state = true
var tracking_state = false
var attacking_state = false
var stunned_state = false
var despawned_state = true
var hiding_spot: Vector2

func _ready() -> void:
	#run variable initialization
	initialize()
	#connect signals
	nav_agent.velocity_computed.connect(_on_velocity_computed)

func initialize():
	#get player and player camera
	player = get_tree().get_first_node_in_group("player")
	player_camera = get_tree().get_first_node_in_group("camera")
	#set current hunger
	current_hunger_stat = default_hunger_stat
	#state bools
	hunting = false
	idle_state = true
	tracking_state = false
	attacking_state = false
	stunned_state = false
	despawned_state = true
	#set off map position (where enemy disappears to)
	hiding_spot = position

func _physics_process(delta: float) -> void:
	#Logic behind which line of sight to use
	if player.is_light_on():
		light_off_vision.disabled = true
		#next line only used for debugging (delete for finished project)
		light_off_vision.visible = false
		light_on_vision.disabled = false
		#next line only used for debugging (delete for finished project)
		light_on_vision.visible = true
	elif !player.is_light_on():
		light_off_vision.disabled = false
		#next line only used for debugging (delete for finished project)
		light_off_vision.visible = true
		light_on_vision.disabled = true
		#next line only used for debugging (delete for finished project)
		light_on_vision.visible = false
	velocity = nav_agent.velocity
	move_and_slide()

#For movement around obstructions
func _on_velocity_computed(safe_velocity: Vector2) -> void:
	velocity.x = safe_velocity.x
	velocity.y = safe_velocity.y

#Hunger check timer logic
func _on_hunger_check_timeout() -> void:
	if hunting:
		print("hunger check skipped")
		return
	var hunt : bool = hunger_check()
	if hunt:
		state_chart.send_event("toTracking")
		hunting = true
	else:
		pass
#Hunger check logic
func hunger_check(chance : float = 50) -> bool:
	var _hunger_check = current_hunger_stat + 1 / chance
	var hunger = randi_range(1 , chance)
	current_hunger_stat += 1
	if hunger <= _hunger_check:
		return true
	else:
		return false
#Line of Sight logic
func _on_vision_timer_timeout() -> void:
	var overlaps = $VisionArea.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				var playerPosition = player.position
				vision_raycast.look_at(playerPosition)
				vision_raycast.force_raycast_update()
				
				if vision_raycast.is_colliding():
					var collider = vision_raycast.get_collider()
					
					if collider.name == "Player":
						state_chart.send_event("toAttack")
						deaggro_timer.stop()
					else:
						pass

#State Chart & related logic

#Tracking State logic
func _on_tracking_state_physics_processing(delta: float) -> void:
	#set target position for navigation
	nav_agent.target_position = player.position
	#check if navigation is finished
	if nav_agent.is_navigation_finished():
		nav_agent.velocity = Vector2.ZERO
		return
	#get next position in path
	var next_pos = nav_agent.get_next_path_position()
	var direction = (next_pos - position).normalized()
	#Set desired velocity
	nav_agent.velocity = Vector2(direction * tracking_speed)
	#rotation to face movement direction
	if direction.length() > 0.01:
		var target_rotation = -atan2(direction.x, direction.y) + deg_to_rad(90)
		rotation = lerp_angle(rotation, target_rotation, 5.0 * delta)
#Tracking State entry logic
func _on_tracking_state_entered() -> void:
	print("tracking")
	#start timer for return to passive state
	deaggro_timer.start()
	#set state bools
	idle_state = false
	tracking_state = true
	attacking_state = false
	stunned_state = false
	#spawn enemy near player
	spawn_enemy()
#enemy spawning logic
func spawn_enemy():
	print(despawned_state)
	if tracking_state:
		print("spawned")
		var random_angle = randf() * TAU
		var random_distance = randf_range(min_spawn_dist, max_spawn_dist)
		var spawn_offset = Vector2(cos(random_angle), sin(random_angle)) * random_distance
		var target_point = player.position + spawn_offset
		var nav_map = nav_agent.get_navigation_map()
		var safe_pos = NavigationServer2D.map_get_closest_point(nav_map, target_point)
		position = safe_pos
	else:
		pass
#restart de-aggro timer when leaving LOS
func _on_vision_area_body_exited(body: Node2D) -> void:
	deaggro_timer.start()
#send back to Idle State
func _on_deaggro_timer_timeout() -> void:
	state_chart.send_event("toIdle")
#entering idle state logic
func _on_idle_state_entered() -> void:
	print("idle state entered")
	#double hunger stat for each tracking state entered
	default_hunger_stat += default_hunger_stat
	current_hunger_stat = default_hunger_stat
	#state bools
	idle_state = true
	tracking_state = false
	attacking_state = false
	stunned_state = false

#Idle State logic
func _on_idle_state_physics_processing(delta: float) -> void:
	#if !despawned_state:
		#find direction to player
		var direction_to_player = position.direction_to(player.position)
		#set flee direction
		var flee_direction = -direction_to_player
		#set velocity
		nav_agent.velocity = flee_direction * flee_speed
		var target_rotation = -atan2(flee_direction.x, flee_direction.y) + deg_to_rad(90)
		rotation = lerp_angle(rotation, target_rotation, 5.0 * delta)
#disappear once off screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	position = hiding_spot
	state_chart.send_event("toDespawn")
#Despawned State logic
func _on_despawned_state_entered() -> void:
	#state bools
	tracking_state = false
	idle_state = false
	attacking_state = false
	stunned_state = false
	despawned_state = true
	#resetting hunting variable for hunger check
	hunting = false
#despawned logic
func _on_despawned_state_physics_processing(delta: float) -> void:
	#set velocity to 0
	nav_agent.velocity = Vector2.ZERO
