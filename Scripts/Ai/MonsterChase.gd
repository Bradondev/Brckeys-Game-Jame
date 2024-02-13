extends State
class_name  MonsterChase



@export var enemy: CharacterBody3D
@export var move_speed := 3

var Player :CharacterBody3D

func Enter():
	Player = LevelLoader.GetPlayer()


func _physics_process(delta:float):
	var direction = Player.global_position - enemy.global_position
	
	if direction.length() > 1:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector3()
	
	if direction.length() > 4:
		print_debug("Idle")
		Transitioned.emit(self,"Idle")
