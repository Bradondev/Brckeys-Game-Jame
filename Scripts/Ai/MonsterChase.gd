extends State
class_name  MonsterChase



@export var enemy: CharacterBody3D
@export var move_speed := 3
var RayCasts :Array[Node]
var Player :CharacterBody3D




func _ready():
	RayCasts = $"../../RaycastHolder".get_children()

func Enter():
	Player = LevelLoader.GetPlayer()
	print_debug("chase")

func Physics_Update(delta:float):
	for Raycast in RayCasts:
		if Raycast.is_colliding():
			$"../../Timer".start()
	
	
	
	
	
	
	var direction = Player.global_position - enemy.global_position
	enemy.look_at(LevelLoader.GetPlayer().transform.origin, Vector3.UP)
	enemy.rotation.x = 0
	if direction.length() > 1:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector3()
	
	if direction.length() > 6:
		Transitioned.emit(self,"Idle")


func _on_timer_timeout():
	Transitioned.emit(self,"Idle")

