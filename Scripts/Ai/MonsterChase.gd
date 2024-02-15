extends State
class_name  MonsterChase


@export var rotationSpeed = 5
@export var enemy: CharacterBody3D
@export var move_speed := 3
var RayCasts :Array[Node]
var Player :CharacterBody3D




func _ready():
	RayCasts = $"../../RaycastHolder".get_children()
func Enter():
	Player = LevelLoader.GetPlayer()
	print_debug("chase")
	$"../../ChaseToDashTimer".start()
	SoundManager.SwitchToMusic("res://Audio/Monster_Chase_Music_-_Final.mp3", .01, .01, 2)
func Physics_Update(delta:float):
	for Raycast in RayCasts:
		if Raycast.is_colliding():
			$"../../ChaseTimer".start()
			break

	var direction = Player.global_position - enemy.global_position
	var new_transform = enemy.transform.looking_at(LevelLoader.GetPlayer().transform.origin, Vector3.UP)
	enemy.transform  = enemy.transform.interpolate_with(new_transform,rotationSpeed * delta)

	if direction.length() > 1:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector3()




func _on_timer_timeout():
	Transitioned.emit(self,"Idle")
	$"../../ChaseToDashTimer".stop()


func _on_chase_to_dash_timer_timeout():
	Transitioned.emit(self,"Dash")
