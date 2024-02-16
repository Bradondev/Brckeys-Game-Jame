extends State
class_name  MonsterDash


@export var DashCounter = 3
@export var enemy: CharacterBody3D
@export var move_speed := 1
@onready var DashRayCast = $"../../DashRayCast"
@onready var DashTimer = $"../../DashTimer"
@onready var AliveTimer = $"../../AliveTimer"
var Player :CharacterBody3D
var bIsScanning = false
var rng
var my_random_number
var colliderPoint : Vector3
var new_transform
func _ready():
	DashCounter = 3
	pass

func Enter():
	if AliveTimer.time_left == 0:
		AliveTimer.start()
	bIsScanning = true
	Player = LevelLoader.GetPlayer()
	print_debug("Dash")
	rng = RandomNumberGenerator.new()
	my_random_number = rng.randf_range(.2, 1)
	enemy.enableKillBox(false)
	SoundManager.SwitchToMusic("res://Audio/Monster_Chase_Music_-_Final.mp3", .01, .01, 2)


func Physics_Update(delta:float):


	if bIsScanning:
		DashRayCast.enabled = true
		enemy.velocity = Vector3.ZERO
		ScanArea(delta)
		if $"../../ScanTimer".time_left == 0:
			$"../../ScanTimer".wait_time = my_random_number
			$"../../ScanTimer".start()
	else:
		if enemy.transform.origin.distance_to(colliderPoint) < .5:
			if DashCounter <= 0:
				ResetCounter()
				rng = RandomNumberGenerator.new()
				var StateNumber = rng.randi_range(1, 2)
				if StateNumber == 1:
					Transitioned.emit(self,"Chase")
				else:
					Transitioned.emit(self,"Idle")
				DashTimer.stop()
			else:
				Enter()
				DashTimer.stop()
			return
		#enemy.look_at(colliderPoint, Vector3.UP)
		var new_transform = enemy.transform.looking_at(colliderPoint, Vector3.UP)
		enemy.transform  =enemy.transform.interpolate_with(new_transform, 10 * delta)
		enemy.velocity = -enemy.transform.basis.z * move_speed * delta
		DashRayCast.enabled = false
		if DashTimer.time_left == 0:
			DashTimer.start()

func ScanArea(delta):

	#enemy.look_at(LevelLoader.GetPlayer().transform.origin, Vector3.UP)
	#var target_position = colliderPoint
	var new_transform = enemy.transform.looking_at(LevelLoader.GetPlayer().transform.origin, Vector3.UP)
	enemy.transform  =enemy.transform.interpolate_with(new_transform, 10 * delta)

func _on_scan_timer_timeout():
	if  DashRayCast.get_collider() !=null and  DashRayCast.get_collider().name =="Player" :
		print_debug(DashRayCast.get_collider() , enemy.transform.origin.distance_to(colliderPoint))
		colliderPoint = DashRayCast.get_collider().global_transform.origin
		bIsScanning = false
		FlickerLights()
		DashCounter -= 1
		enemy.enableKillBox(true)
	else:
		Transitioned.emit(self,"Idle")

func ResetCounter():
	DashCounter = rng.randi_range(1, 3)


func FlickerLights():
	var lights = get_tree().get_nodes_in_group("Lights")
	for light in lights:
		await get_tree().create_timer(randf_range(.01, .3)).timeout
		light.UpdateLight()


func _on_dash_timer_timeout():
	Transitioned.emit(self,"Idle")


func _on_alive_timer_timeout():
	LevelLoader.GetMonster().queue_free()
