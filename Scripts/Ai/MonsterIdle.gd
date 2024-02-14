extends State
class_name  MonsterIdle

@export var enemy: CharacterBody3D
@export var move_speed := 10



@export var PathPoints : Array[MonsterPath]

var RayCasts :Array[Node]
var  Move_direction :Vector3
var wander_time:float
var target
var Temp =0

func _ready():
	RayCasts = $"../../RaycastHolder".get_children()
func randomize_wander():
	if Temp > PathPoints.size() - 1:
		Temp = 0
	target =PathPoints[Temp].transform.origin
	Temp+=1
	
	#Move_direction = Vector3(randf_range(-1,1),randf_range(0,0),randf_range(-1,1)).normalized()
	#wander_time = randf_range(1,3)
func Enter():
	#RayCasts = $"../../RaycastHolder".get_children()
	randomize_wander()
	print_debug("idle")
func Update(delte:float):
	#if wander_time > 0:
	#	wander_time -=delte
	#else:
	#	randomize_wander()
	for Raycast in RayCasts:
		if Raycast.is_colliding() and Raycast.get_collider() == LevelLoader.GetPlayer() :
			print_debug(Raycast.get_collider())
			Transitioned.emit(self,"Chase")
			break

	if enemy.transform.origin.distance_to(target) < 1:
		target = Vector3.ZERO
		enemy.velocity = Vector3.ZERO
		randomize_wander()
func Physics_Update(delta:float):	

	
	if enemy:
		enemy.look_at(target, Vector3.UP)
		enemy.rotation.x = 0
		enemy.velocity = -enemy.transform.basis.z * move_speed
	
	var direction = LevelLoader.GetPlayer().global_position - enemy.global_position
	
	#if direction.length() < 4:
	#	
		#Transitioned.emit(self,"Chase")
	
