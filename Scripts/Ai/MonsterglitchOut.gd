
extends State
class_name  MonsterGlitchOut





func  Enter():
	print_debug("Glitch Out")
	enemy.SetSpotLightRed()
	enemy.velocity = Vector3.ZERO
	var result = randi() % 3

	if result == 0:
		enemy.PlayAnimation("Glitch1")
	elif result == 1:
		enemy.PlayAnimation("Glitch2")
	else:
		enemy.PlayAnimation("Glitch3")


func Exit():
	pass
func  Update(_delta:float):
	pass
func Physics_Update(_delta:float):
	pass





func _on_animation_player_animation_finished(anim_name):
	if "Glitch" in anim_name:
		LevelLoader.GetLevel().PassPointToZero()
