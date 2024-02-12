extends Node3D


func _ready():
	add_to_group("Level")
	LevelLoader.MovePlayerToPosition()
	print("room loaded: " + name)
