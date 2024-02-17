extends Node

var PlayerMoveToPosition = "-1"

var Data = {}
var Master =-4
var Music=-5
var SFX=-10
var Rumbles = 0
var RumblesToSpawnEnemy = 20

var master_Bus = AudioServer.get_bus_index("Master")
var music_Bus = AudioServer.get_bus_index("Music")
var sfx_Bus = AudioServer.get_bus_index("SFX")

var bHasWon = false

func _ready():
	LoadSettings()
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


func SaveSettings():
	Master = get_tree().get_nodes_in_group("MasterSetting")[0].value
	Music = get_tree().get_nodes_in_group("MusicSetting")[0].value
	SFX = get_tree().get_nodes_in_group("SFXSetting")[0].value

func LoadSettings():
	SetBusVolume(sfx_Bus, SFX)
	SetBusVolume(music_Bus, Music)
	SetBusVolume(master_Bus, Master)

func SetBusVolume(busName, volume):

	AudioServer.set_bus_volume_db(busName, volume)
	if volume == -30:
		SetBusMute(busName, true)
	else:
		SetBusMute(busName, false)

func SetBusMute(busName, bIsMuted):
	AudioServer.set_bus_mute(busName, bIsMuted)

func Reset():
	SetPlayerMoveToPosition("-1")
	RumblesToSpawnEnemy = 20
	Rumbles = 0
	Data.clear()

func ResetRumbles():
	if RumblesToSpawnEnemy <= 10:
		RumblesToSpawnEnemy = 10
	Rumbles = 0
