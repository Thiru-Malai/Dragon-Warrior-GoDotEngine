extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Levels/level_2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://Levels/level_3.tscn")


func _on_exit_pressed():
	get_tree().quit()
