extends Node3D
class_name InterActiveObject
signal OnInterAct
var PopUp
var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("InterActiveObject")
	PopUp = get_node("PopUp")
