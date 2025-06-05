extends Control



func _on_resume_pressed() -> void:
	get_tree().change_scene_to_file("res://node_3d.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/options.tscn")


func _on_title_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
