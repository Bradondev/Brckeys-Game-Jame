
extends State
class_name  MonsterGlitchOut





func  Enter():
	print_debug("Glitch Out")
	enemy.velocity = Vector3.ZERO
	enemy.PlayAnimation("exitGlitch")
func Exit():
	pass
func  Update(_delta:float):
	pass
func Physics_Update(_delta:float):
	pass


		


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "exitGlitch":
		LevelLoader.GetLevel().PassPointToZero()
