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
	if MonsterSpawnChance > 0:
		var result = randi() % 100
		if result <= MonsterSpawnChance:
			MonsterRef = load("res://monster.tscn").instantiate()
			add_child(MonsterRef)
			SetRandomPatrolPoint(MonsterRef)
			emit_signal("SpawnEnemy")




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
