extends Node3D

@export var RoomToGoTo = "1.tscn"






func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		var currentLevel = get_tree().get_nodes_in_group("Level")
		if currentLevel:
			LevelLoader.SetPlayerMoveToPosition(currentLevel[0].name)
			get_tree().change_scene_to_file("res://Scenes/Levels/" + RoomToGoTo)
