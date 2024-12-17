extends CharacterBody2D

@export var move_speed: float = 50
@onready var animated_sprite = $AnimatedSprite2D
var interia : int = 100;

func _physics_process(delta):
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	# Default to idle animation
	var animation = "idle"
	
	# Determine animation based on input
	if input_direction.x > 0:
		animated_sprite.flip_h = false
		animation = "walk_right"
	elif input_direction.x < 0:
		animated_sprite.flip_h = true
		animation = "walk_right"
	elif input_direction.y < 0:  # Upward movement
		animation = "walk_up"
	elif input_direction.y > 0:  # Downward movement
		animation = "walk_down"
	
	# Play the determined animation if it changes
	if animated_sprite.animation != animation:
		animated_sprite.play(animation)
	
	# Update velocity
	velocity = input_direction * move_speed
	
	# Move the character
	move_and_slide()
