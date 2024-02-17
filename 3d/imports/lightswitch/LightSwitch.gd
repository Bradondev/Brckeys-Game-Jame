extends Node3D


func TurnOn():
	$AnimationPlayer.play("on")

func TurnOff():
	$AnimationPlayer.play("off")
