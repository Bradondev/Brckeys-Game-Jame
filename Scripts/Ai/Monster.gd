extends CharacterBody3D
class_name  Monster


func _enter_tree():
	LevelLoader.GetLevel().SetDoorsEnabled(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	move_and_slide()
	rotation.x = 0
	rotation.z = 0
	if velocity.length() > 0:
		# Play walk Animation
		pass

	#make Monster look where its moving

func _exit_tree():
	SoundManager.SwitchToMusic("res://Audio/Brandon_x4_-_Brackey_Jam_-_Ambient_Background_Music_-_Optimized.mp3", .1, .1)
	LevelLoader.GetLevel().SetDoorsEnabled(true)

func GetStateMachine():
	return $"State Machine"

func _on_kill_box_body_entered(body):
	if body.name == "Player":
		body.TakeDamage()

func enableKillBox(bEnable):
	$KillBOX.monitoring = bEnable
func ChangeState(StateName):
	$"State Machine".ChangeState(StateName)
func GetFarestPointFromPlayer():
	return $"State Machine/Idle".FindFarestPointFromPlayer()


func _on_kill_box_body_exited(body):
	if body.name == "Player":
		body.TakeDamage()
