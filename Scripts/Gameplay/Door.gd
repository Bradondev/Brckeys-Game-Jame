extends InterActiveObject

@export var RoomToGoTo = "1.tscn"



@export var  bCanEnterDoor = true
@export var SceneDirectory = "res://Scenes/Levels/"
@export var DoorType = 0

var bHasEnteredDoor = false
var bDisabled = false

var Knocks = 0

func EnableDoor(bEnable):
	bDisabled = !bEnable
	$PopUp.bIsLocked = bCanEnterDoor == false and bEnable


func _ready():
	super._ready()
	$PopUp.bIsLocked = bCanEnterDoor == false
	add_to_group("Doors")


func _enter_tree():
	#if DoorType == 1:
	#	$doorStandard/door.mesh = load("res://3d/meshes/Mesh_BlueDoor.tres")
	#elif DoorType == 2:
	#	$doorStandard/door.mesh = load("res://3d/meshes/Mesh_YellowDoor.tres")
	pass



func UnlockDoor():
	bCanEnterDoor = true
	$PopUp.bIsLocked = false

func KnockCheck():
	if Knocks >= 3:
		Knocks = 0
		if is_instance_valid(LevelLoader.GetMonster()):
			if LevelLoader.GetMonster().GetStateMachine().IsDashing() == false:
				LevelLoader.GetMonster().ChangeState("dash")

func InterAct():
	Knocks += 1
	if get_node_or_null("Timer"):
		$Timer.start()

	var level = LevelLoader.GetLevel()
	if bDisabled:
		SoundManager.PlaySFX("res://Audio/Door Failed To Open.mp3", global_position)
		KnockCheck()
		return
	if bCanEnterDoor == false:
		KnockCheck()
		SoundManager.PlaySFX("res://Audio/Door Failed To Open.mp3", global_position)
		LevelLoader.Rumbles += 1


		if level.CanSpawnEnemy():
			level.AttemptSpawnEnemy(true)

		return

	if bHasEnteredDoor:
		return

	SoundManager.PlaySFX("res://Audio/Door Opening.mp3", global_position)
	bHasEnteredDoor = true
	$AnimationPlayer.play("DoorOpen")
	LevelLoader.GetPlayer().PlayFade(true)
	LevelLoader.Rumbles += 1



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "DoorOpen":
		var currentLevel = get_tree().get_nodes_in_group("Level")
		if currentLevel:
			LevelLoader.SetPlayerMoveToPosition(currentLevel[0].name)

			if SceneDirectory != "res://Scenes/Levels/":
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().change_scene_to_file(SceneDirectory + RoomToGoTo)


func _on_timer_timeout():
	if Knocks > 0:
		Knocks -= 1
	pass # Replace with function body.
