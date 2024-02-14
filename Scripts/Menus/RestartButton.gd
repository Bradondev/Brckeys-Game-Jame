extends ButtonBase

func _on_button_up():
	LevelLoader.Reset()
	get_tree().change_scene_to_file("res://Scenes/Levels/1.tscn")
