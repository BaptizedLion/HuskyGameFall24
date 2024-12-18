extends Node2D

# Define the signal at the top of the script
signal player_detected(camera)
signal player_lost(camera)

@export var rotation_speed: float = 1.0
@export var rotation_range: float = 90.0
@export var detection_distance: float = 200.0
@export var detection_angle: float = 45.0

var current_rotation: float = 0.0
var rotation_direction: int = 1
var is_currently_detecting: bool = false

@onready var raycast: RayCast2D = $RayCast2D
@onready var line_of_sight: Node2D = $LineOfSight
@onready var security_camera = $"."

func _ready():
	var camera = $"."

	raycast.enabled = true
	raycast.target_position = Vector2(detection_distance, 0)

func _process(delta):
	current_rotation += rotation_speed * rotation_direction * delta
	
	if abs(current_rotation) >= rotation_range / 2:
		rotation_direction *= -1
	
	rotation_degrees = current_rotation

func _physics_process(delta):
	var player_now_detected = is_player_detected()
	
	# Check for detection state change
	if player_now_detected and not is_currently_detecting:
		# Player just got detected
		is_currently_detecting = true
		emit_signal("player_detected", self)
	elif not player_now_detected and is_currently_detecting:
		# Player just lost
		is_currently_detecting = false
		emit_signal("player_lost", self)

func is_player_detected() -> bool:
	raycast.target_position = Vector2(detection_distance, 0)
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		return collider.is_in_group("player")
	
	return false
	
func _draw():
	# Visualize the field of view (debug purposes)
	var line_length = detection_distance
	var half_angle = detection_angle / 2.0
	
	draw_line(Vector2.ZERO, 
			  Vector2(line_length, -deg_to_rad(half_angle)), 
			  Color.RED, 2.0)
	draw_line(Vector2.ZERO, 
			  Vector2(line_length, deg_to_rad(half_angle)), 
			  Color.RED, 2.0)
