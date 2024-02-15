extends Node3D

func _ready():
	TurnOff()

func TurnOn():
	$AnimationPlayer.play("on")

func TurnOff():
	$AnimationPlayer.play("off")
