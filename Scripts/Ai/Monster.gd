extends CharacterBody3D
class_name  Monster


func _enter_tree():
	LevelLoader.GetLevel().SetDoorsEnabled(false)
	SoundManager.PlaySFX("res://Audio/Monster_Growl_-_2_-_Louder.mp3", global_position)

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
	GetKillBox().monitoring = bEnable
func ChangeState(StateName):
	$"State Machine".ChangeState(StateName)
func GetFarestPointFromPlayer():
	return $"State Machine/Idle".FindFarestPointFromPlayer()


func _on_kill_box_body_exited(body):
	if body.name == "Player":
		body.TakeDamage()
func PlayAnimation(AnimationName, StartTime = 0.0):
	$JerryFixed/JerryFixed/AnimationPlayer.play(AnimationName)
	$JerryFixed/JerryFixed/AnimationPlayer.seek(StartTime)
func GetScanRayCasts():
	return $JerryFixed/JerryFixed/metarig/Skeleton3D/HeadAttachment/RaycastHolder.get_children()
func GetKillBox():
	return $JerryFixed/JerryFixed/metarig/Skeleton3D/HeadAttachment/KillBOX
func GetDashRayCast():
	return $JerryFixed/JerryFixed/metarig/Skeleton3D/HeadAttachment/DashRayCast
func GetSpotLight():
	return $JerryFixed/JerryFixed/metarig/Skeleton3D/HeadAttachment/SpotLight3D

	
	 
	
	
	
	
	
