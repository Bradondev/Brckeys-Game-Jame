extends State
class_name  MonsterScan


func  Enter():
	print_debug("Scan")
	enemy.velocity = Vector3.ZERO
	var result = randi() % 2
	if result == 0:
		enemy.PlayAnimation("lookAround2")
	else:
		enemy.PlayAnimation("lookAround1")
func Exit():
	pass
	
	
func  Update(_delta:float):
	for Raycast in enemy.GetScanRayCasts():
		if Raycast.is_colliding() and Raycast.get_collider() == LevelLoader.GetPlayer() :
			ChangeToRandomState()
			break

func Physics_Update(_delta:float):
	pass
	
func ChangeToRandomState():
	var rng = RandomNumberGenerator.new()
	var StateNumber = rng.randi_range(1, 4)
	if StateNumber == 1:
		Transitioned.emit(self,"Chase")
	else:
		Transitioned.emit(self,"Dash")
		
		


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "lookAround1" or "lookAround2" == anim_name:
			Transitioned.emit(self,"Idle")
		
