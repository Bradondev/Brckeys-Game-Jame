extends State
class_name  MonsterDash


@export var DashCounter = 3
@export var enemy: CharacterBody3D
@export var move_speed := 1
@onready var DashRayCast = $"../../DashRayCast"

var Player :CharacterBody3D
var bIsScanning = false
var rng 
var my_random_number
var colliderPoint : Vector3
var new_transform 
func _ready():
	pass

func Enter():
	DashCounter -= 1
	bIsScanning = true
	Player = LevelLoader.GetPlayer()
	print_debug("Dash")
	rng = RandomNumberGenerator.new()
	my_random_number = rng.randf_range(.5, 2)
	enemy.enableKillBox(false)
	

func Physics_Update(delta:float):

	
	if bIsScanning:
		DashRayCast.enabled = true
		enemy.velocity = Vector3.ZERO
		ScanArea(delta)
		if $"../../ScanTimer".time_left == 0:
			$"../../ScanTimer".wait_time = my_random_number
			$"../../ScanTimer".start()
	else:
		if enemy.transform.origin.distance_to(colliderPoint) < 1:
			if DashCounter <= 0:
				ResetCounter()
				Transitioned.emit(self,"Idle")
				enemy.enableKillBox(false)
			else:
				Enter()
			return
		var target_position = colliderPoint
		var new_transform = enemy.transform.looking_at(target_position, Vector3.UP)
		enemy.transform  =enemy.transform.interpolate_with(new_transform, 5 * delta)
		#enemy.look_at(colliderPoint, Vector3.UP)
		enemy.velocity = -enemy.transform.basis.z * move_speed * delta
		DashRayCast.enabled = false
	

func ScanArea(delta):

	enemy.look_at(LevelLoader.GetPlayer().transform.origin, Vector3.UP)
	#var target_position = colliderPoint
	#var new_transform = enemy.transform.looking_at(LevelLoader.GetPlayer().transform.origin., Vector3.UP)
	#enemy.transform  =enemy.transform.interpolate_with(new_transform, 5 * delta)

func _on_scan_timer_timeout():
	if  DashRayCast.get_collider() !=null:
		colliderPoint = DashRayCast.get_collider().transform.origin
		bIsScanning = false
		enemy.enableKillBox(true)
		new_transform = enemy.transform.looking_at(colliderPoint, Vector3.UP)
	else:
		Transitioned.emit(self,"Idle")
	
func ResetCounter():
	DashCounter = rng.randi_range(1, 3)
	
