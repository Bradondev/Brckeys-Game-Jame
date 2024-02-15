extends State
class_name  MonsterIdle

@export var enemy: CharacterBody3D
@export var move_speed := 10
@export var rotationSpeed = 5


var PathPoints : Array[Node]

var RayCasts :Array[Node]
var  Move_direction :Vector3
var wander_time:float
var target
var Temp =0

signal PassPoint

func _ready():

	PathPoints = get_tree().get_nodes_in_group("MonsterPath")
	RayCasts = $"../../RaycastHolder".get_children()
func randomize_wander():


	if Temp > PathPoints.size() - 1:
		Temp = 0
	target =PathPoints[Temp].transform.origin
	Temp+=1
	emit_signal("PassPoint")

func SetTemp(index):
	Temp = index
	PathPoints = get_tree().get_nodes_in_group("MonsterPath")
	target =PathPoints[Temp].transform.origin
	randomize_wander()

func Enter():
	enemy.enableKillBox(false)
	FindClosesIdlePath()
	randomize_wander()
	print_debug("idle")

func Update(delte:float):
	for Raycast in RayCasts:
		if Raycast.is_colliding() and Raycast.get_collider() == LevelLoader.GetPlayer() :
			print_debug(Raycast.get_collider())
			ChangeToRandomState()
			break

	if enemy.transform.origin.distance_to(target) < 2:
		target = Vector3.ZERO
		enemy.velocity = Vector3.ZERO
		randomize_wander()

func Physics_Update(delta:float):

	if enemy.transform.origin.distance_to(target) < 2:
		return

	if enemy:
		var new_transform = enemy.transform.looking_at(target, Vector3.UP)
		enemy.transform  = enemy.transform.interpolate_with(new_transform,rotationSpeed * delta)

		enemy.velocity = -enemy.transform.basis.z * move_speed

	var direction = LevelLoader.GetPlayer().global_position - enemy.global_position


func ChangeToRandomState():
	var rng = RandomNumberGenerator.new()
	var StateNumber = rng.randi_range(1, 4)
	if StateNumber == 1:
		Transitioned.emit(self,"Chase")
	else:
		Transitioned.emit(self,"Dash")
func FindClosesIdlePath():
	var Distance = PathPoints[0].global_position - enemy.global_position
	var ClosestPath
	var ClosetDistance  = 9000
	for PathPoint in PathPoints:
		var DistanceToPathPoint = PathPoint.global_position.distance_to(enemy.global_position)
		print_debug(DistanceToPathPoint , PathPoint.name )
		if ClosetDistance > DistanceToPathPoint :
			ClosestPath = PathPoint
			ClosetDistance =DistanceToPathPoint
	Temp = PathPoints.find(ClosestPath) + 1
	print_debug(Temp)

