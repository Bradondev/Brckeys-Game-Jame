extends Node3D
class_name  Switch
signal Fliped

@export_enum("1","2","3","4","5","6","7","8","9","10","11","12","13","14") var Switchlocation: String

var Name ="Switch"
func _ready():
	add_to_group(Switchlocation)
func  SwitchFliped():
	print_debug("Fliped")
	emit_signal("Fliped")
