extends Node3D



var Moving = false
func _on_inter_hit_box_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("Kill")
		Moving =true



func _on_outer_hit_box_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("Warning")
		Moving =true



func _on_inter_hit_box_body_exited(body):
	$AnimationPlayer.play("Reset")


func _on_outer_hit_box_body_exited(body):
	$AnimationPlayer.play("Reset2")


func _on_kill_zone_body_entered(body):
	if body.name == "Player":
		body.TakeDamage()
		
