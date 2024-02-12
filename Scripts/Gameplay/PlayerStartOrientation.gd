extends Node3D

@export var SpawnPoint = "0"

func _enter_tree():
	visible = false
	add_to_group("PlayerOrientation")

func UpdatePlayerPosition():
	var player = LevelLoader.GetPlayer()
	player.global_position = global_position
	player.global_rotation = global_rotation
