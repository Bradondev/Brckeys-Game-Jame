extends SpotLight3D
class_name BaseLight

@export var MinPowerLight = 1
@export var MaxPowerOfLight = 2
@export var On = true
var SwitchConnect 
@export_enum("1","2","3","4","5","6","7","8","9","10","11","12","13","14") var SwitchToConnectTo: String
# Called when the node enters the scene tree for the first time.
func _ready():
	ConnectToSwitch()
	if On:
		TurnOnLight()
	else: 
		TurnOffLight()



func  TurnOnLight():
	light_energy = MaxPowerOfLight
	On = true
func  TurnOffLight():
	light_energy = 0
	On = false

	
func  UpdateLight():
	if On:
		TurnOffLight()
	elif  !On:
		TurnOnLight()
func ConnectToSwitch():
	SwitchConnect = get_tree().get_nodes_in_group(SwitchToConnectTo)
	for Switchs in SwitchConnect:
		Switchs.connect("Fliped", UpdateLight)

