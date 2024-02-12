extends Node3D
class_name InterActiveObject
signal OnInterAct
@export var PopUp : Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("InterActiveObject")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
