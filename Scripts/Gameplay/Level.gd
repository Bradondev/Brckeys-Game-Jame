extends Node3D

@export var MonsterSpawnChance = 0

@export var PointsToPassBeforeDeath = 3

var MonsterRef = null

signal SpawnEnemy

func _ready():
	add_to_group("Level")
	LevelLoader.MovePlayerToPosition()
	print("room loaded: " + name)


	await get_tree().process_frame
	await get_tree().process_frame
	AttemptSpawnEnemy()


func CanSpawnEnemy():
	return MonsterSpawnChance > 0 and is_instance_valid(MonsterRef) == false


func RandomRumbleCheck():
	return LevelLoader.Rumbles >= LevelLoader.RumblesToSpawnEnemy + randi() % 5

func AttemptSpawnEnemy(bUseClosestPoint = false):
		if CanSpawnEnemy():
			var result = randi() % 100
			if RandomRumbleCheck():
				result = 0
				LevelLoader.Rumbles = 0
				LevelLoader.RumblesToSpawnEnemy -= 1

			if result <= MonsterSpawnChance:
				MonsterRef = load("res://monster.tscn").instantiate()
				add_child(MonsterRef)
				if bUseClosestPoint == false:
					SetRandomPatrolPoint(MonsterRef)
				else:
					# MT: Find closest patrol point to player
					pass
				emit_signal("SpawnEnemy")
				SetDoorsEnabled(false)


func SetRandomPatrolPoint(monster):
	var monsterPaths =  get_tree().get_nodes_in_group("MonsterPath")
	var chosenPath = randi() % (len(monsterPaths) / 2)
	monster.global_position = monsterPaths[chosenPath].global_position
	var idleState = monster.GetStateMachine().GetIdleState()
	idleState.SetTemp(chosenPath)
	idleState.connect("PassPoint", Callable(self, "OnPassPoint"))

func OnPassPoint():
	PointsToPassBeforeDeath -= 1
	if PointsToPassBeforeDeath <= 0:
		MonsterRef.queue_free()
		SetDoorsEnabled(true)
		SoundManager.SwitchToMusic("res://Audio/Brandon_x4_-_Brackey_Jam_-_Ambient_Background_Music_-_Optimized.mp3", .5, .5)
		FlickerLights()
		await get_tree().create_timer(.4).timeout
		FlickerLights()
		await get_tree().create_timer(.3).timeout
		FlickerLights()
		await get_tree().create_timer(.2).timeout
		FlickerLights()
		await get_tree().create_timer(.1).timeout
		FlickerLights()
		await get_tree().create_timer(.1).timeout
		FlickerLights()


func SetDoorsEnabled(bEnable):
	var doors = get_tree().get_nodes_in_group("Doors")
	for door in doors:
		door.EnableDoor(bEnable)

func FlickerLights():
	var lights = get_tree().get_nodes_in_group("Lights")
	for light in lights:
		await get_tree().create_timer(randf_range(.01, .3)).timeout
		light.UpdateLight()
