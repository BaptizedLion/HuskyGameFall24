extends CharacterBody2D
@export var move_speed : float = 50
@onready var animated_sprite = $AnimatedSprite2D
func _physics_process(delta):
	# get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)	


	var direction = Input.get_axis("left", "right")
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#Play animations
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walk") 
	
	if Input.is_action_pressed("bite"):
		animated_sprite.play("bite")
	
	if direction:
			velocity.x = direction * move_speed
	else:
			velocity.x = move_toward(velocity.x, 0 , move_speed)
	
	print(input_direction)
	#update velocity
	velocity = input_direction * move_speed
	#Move and slide function uses velocity of character body to move character on map
	move_and_slide()
