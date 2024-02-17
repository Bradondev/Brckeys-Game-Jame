extends State
class_name  MonsterDash


@export var DashCounter = 3

@export var move_speed := 1
@onready var DashTimer = $"../../DashTimer"
@onready var AliveTimer = $"../../AliveTimer"
var Player :CharacterBody3D
var bIsDashing = false
var rng
var my_random_number
var colliderPoint : Vector3
var new_transform
func _ready():
	DashCounter = 3
	pass

func Enter():
	enemy.Agro = true
	enemy.velocity = Vector3.ZERO
	bIsDashing = false
	colliderPoint = LevelLoader.GetPlayer().global_transform.origin
	FlickerLights()
	DashCounter -= 1
	enemy.PlayAnimation("lunge", .7)
	if AliveTimer.time_left == 0:
		AliveTimer.start()
	Player = LevelLoader.GetPlayer()
	print_debug("Dash")
	rng = RandomNumberGenerator.new()
	my_random_number = rng.randf_range(.2, 1)
	enemy.enableKillBox(true)
	SoundManager.SwitchToMusic("res://Audio/Monster_Chase_Music_-_Final.mp3", .01, .01, 2)


func Physics_Update(delta:float):
	if bIsDashing == false:
		colliderPoint = LevelLoader.GetPlayer().global_transform.origin
		new_transform = enemy.transform.looking_at(colliderPoint, Vector3.UP)
		enemy.transform  =enemy.transform.interpolate_with(new_transform, 20 * delta)
		return
	if enemy.transform.origin.distance_to(colliderPoint) < 1:
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
	enemy.velocity = -enemy.transform.basis.z * move_speed * delta
	enemy.GetDashRayCast().enabled = false
	if DashTimer.time_left == 0:
		DashTimer.start()

func ScanArea(delta):

	new_transform = enemy.transform.looking_at(LevelLoader.GetPlayer().transform.origin, Vector3.UP)
	enemy.transform  =enemy.transform.interpolate_with(new_transform, 10 * delta)

func ResetCounter():
	DashCounter = rng.randi_range(1, 3)

func FlickerLights():
	LevelLoader.GetLevel().FlickerLights()


func _on_dash_timer_timeout():
	Transitioned.emit(self,"Idle")

func _on_alive_timer_timeout():
	LevelLoader.GetLevel().ForceEnemyDeath()

func Exit():
	enemy.enableKillBox(false)
	bIsDashing = false




func _on_jerry_fixed_start_dash():
	colliderPoint = LevelLoader.GetPlayer().global_transform.origin
	if SoundManager.CheckSFXRunning(9) == false:
		if randi() % 2 == 0:
			SoundManager.PlaySFX("res://Audio/Monster_Scream.mp3", enemy.global_position,9, 0)
		else:
			SoundManager.PlaySFX("res://Audio/Monster_Scream_-_2.mp3", enemy.global_position,9, 0)
	bIsDashing = true
