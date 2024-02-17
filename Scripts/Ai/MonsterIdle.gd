extends State
class_name  MonsterIdle

@export var move_speed := 10
@export var rotationSpeed = 5


var PathPoints : Array[Node]


var  Move_direction :Vector3
var wander_time:float
var target
var Temp =0
signal PassPoint

var bWalkBackwards = false
func _ready():

	PathPoints = get_tree().get_nodes_in_group("MonsterPath")
	
func randomize_wander():
	if bWalkBackwards == false:
		Temp +=1
		if Temp > PathPoints.size() - 1:
			Temp = 0
	else:
		Temp -=  1
		if Temp < 0:
			Temp = PathPoints.size() - 1
	target =PathPoints[Temp].transform.origin

	emit_signal("PassPoint")
	if Temp % 4 == 0:
		Transitioned.emit(self,"Scan")
func SetTemp(index):
	Temp = index
	PathPoints = get_tree().get_nodes_in_group("MonsterPath")
	target =PathPoints[Temp].transform.origin
	randomize_wander()

func Enter():
	enemy.Agro = false
	enemy.PlayAnimation("walk")
	enemy.enableKillBox(false)
	FindClosesIdlePath()
	randomize_wander()
	print_debug("idle")
	var result = randi() % 2
	if result == 0:
		bWalkBackwards = true
	else:
		bWalkBackwards = false


func Update(_delte:float):
	for Raycast in enemy.GetScanRayCasts():
		if Raycast.is_colliding() and Raycast.get_collider() == LevelLoader.GetPlayer() :
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

func FindClosesIdlePath():
	var ClosestPath
	var ClosetDistance  = 9000
	for PathPoint in PathPoints:
		var DistanceToPathPoint = PathPoint.global_position.distance_to(enemy.global_position)
		#print_debug(DistanceToPathPoint , PathPoint.name )
		if ClosetDistance > DistanceToPathPoint :
			ClosestPath = PathPoint
			ClosetDistance =DistanceToPathPoint
	Temp = PathPoints.find(ClosestPath) + 1
	#print_debug(Temp)

func ChangeToRandomState():
	var rng = RandomNumberGenerator.new()
	var StateNumber = rng.randi_range(1, 4)
	if StateNumber == 1:
		Transitioned.emit(self,"Chase")
	else:
		Transitioned.emit(self,"Dash")
		
