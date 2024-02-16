extends Node3D

func _enter_tree():
	TurnOff()

func TurnOn():
	$Plane_002.position.y = -0.101

func TurnOff():
	$Plane_002.position.y = -0.198

