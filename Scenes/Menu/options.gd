extends Control


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value/5)


func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")
