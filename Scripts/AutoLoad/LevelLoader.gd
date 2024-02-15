extends Node

var PlayerMoveToPosition = "-1"

var Data = {}

var Rumbles = 0
var RumblesToSpawnEnemy = 12

func _ready():
	Reset()

func SetPlayerMoveToPosition(newPosition):
	PlayerMoveToPosition = newPosition

func MovePlayerToPosition():
	var playerStarts =  get_tree().get_nodes_in_group("PlayerOrientation")
	for start in playerStarts:
		if start.SpawnPoint == PlayerMoveToPosition:
			start.UpdatePlayerPosition()
			break

func GetPlayer():
	var player = get_tree().get_nodes_in_group("Player")
	if player:
		return player[0]
func GetMonster():
	var monster = get_tree().get_nodes_in_group("monster")
	if monster:
		return monster[0]


func GetLevel():
	var level = get_tree().get_nodes_in_group("Level")
	if level:
		return level[0]


func GetObjectName(object):
	return get_tree().current_scene.name + object.name

func Save(object, data):
	Data[GetObjectName(object)] = data

func SavePlayer(data):
	Data["Player"] = data

func LoadPlayer():
	if Data.has("Player"):
		return Data["Player"]
	return null

func Load(object):
	if Data.has(GetObjectName(object)):
		return Data[GetObjectName(object)]
	return null

func Reset():
	SetPlayerMoveToPosition("-1")
	RumblesToSpawnEnemy = 12
	Data.clear()
