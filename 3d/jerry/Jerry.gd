extends Node3D

signal  StartDash
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Dash():
	emit_signal("StartDash")
