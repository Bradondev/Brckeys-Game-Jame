extends Node

var PlayerMoveToPosition = "-1"


func SetPlayerMoveToPosition(newPosition):
	PlayerMoveToPosition = newPosition

func MovePlayerToPosition():
	var playerStarts =  get_tree().get_nodes_in_group("PlayerOrientation")
	for start in playerStarts:
		if start.SpawnPoint == PlayerMoveToPosition:
			start.UpdatePlayerPosition()

func GetPlayer():
	var player = get_tree().get_nodes_in_group("Player")
	if player:
		return player[0]
