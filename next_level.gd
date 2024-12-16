extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("collided with body")
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		var next_level_path = "res://Levels/level_" + str(next_level_number) + ".tscn"
		print(next_level_number)
		get_tree().change_scene_to_file(next_level_path)
