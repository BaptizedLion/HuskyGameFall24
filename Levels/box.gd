extends RigidBody2D

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var linear_velocity = state.linear_velocity
	# Restrict movement to cardinal directions
	if abs(linear_velocity.x) > abs(linear_velocity.y):
		linear_velocity.y = 0  # Allow only horizontal movement
	else:
		linear_velocity.x = 0  # Allow only vertical movement
	# Apply the modified velocity
	state.linear_velocity = linear_velocity


