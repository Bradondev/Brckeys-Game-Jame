extends Button

func _on_button_up():
	LevelLoader.SetPlayerMoveToPosition("-1")
	get_tree().change_scene_to_file("res://Scenes/Levels/1.tscn")
