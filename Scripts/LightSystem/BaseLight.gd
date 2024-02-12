extends SpotLight3D
class_name BaseLight


@export_enum("1","2","3","4","5","6","7","8","9","10","11","12","13","14") var SwitchToConnectTo: String
@export var MinPowerLight = 1
@export var MaxPowerOfLight = 2
@export var On = true
@export var FlickeringLoop :float
@export var Flickering = false


@onready var FlickerTimer=$Timer

var SwitchConnect
var NoStopingFlicking = true
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	FlickerTimer.wait_time = FlickeringLoop
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

func StartFlickingLights():
	$Timer.Start()
	Flickering = true



func _on_timer_timeout():
	if Flickering:
		var my_random_number
		if NoStopingFlicking:
			my_random_number =0
		else:
			my_random_number = rng.randf_range(-10.0, 10.0)
		if my_random_number >=0:
			UpdateLight()

func  StopFlickingLights():
	$Timer.Stop()
	Flickering = false
