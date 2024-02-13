extends Node3D

@export var RoomToGoTo = "1.tscn"



@export var  bCanEnterDoor = true
@export var SceneDirectory = "res://Scenes/Levels/"
@export var DoorType = 0

var bHasEnteredDoor = false

func _enter_tree():
	if DoorType == 1:
		$doorStandard/door.mesh = load("res://3d/meshes/Mesh_BlueDoor.tres")
	elif DoorType == 2:
		$doorStandard/door.mesh = load("res://3d/meshes/Mesh_YellowDoor.tres")


func UnlockDoor():
	bCanEnterDoor = true

func _on_area_3d_body_entered(body):
	if bCanEnterDoor == false:
		return

	if bHasEnteredDoor:
		return

	if body.is_in_group("Player"):
		bHasEnteredDoor = true
		$AnimationPlayer.play("DoorOpen")
		LevelLoader.GetPlayer().PlayFade(true)



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "DoorOpen":
		var currentLevel = get_tree().get_nodes_in_group("Level")
		if currentLevel:
			LevelLoader.SetPlayerMoveToPosition(currentLevel[0].name)

			if SceneDirectory != "res://Scenes/Levels/":
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().change_scene_to_file(SceneDirectory + RoomToGoTo)
