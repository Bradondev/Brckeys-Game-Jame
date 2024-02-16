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

var RandomPitchScale
var RandomVolume
var Colors = [
	"ffff37",
	"fff1f3",
	"ecffba"
	]
# Called when the node enters the scene tree for the first time.
func _ready():
	light_color = Colors[randi() % len(Colors)]
	RandomPitchScale = randf_range(.8, 1.2)
	RandomVolume = randf_range(-20.0, -10.0)
	if FlickeringLoop > 0.0:
		FlickerTimer.wait_time = FlickeringLoop
	ConnectToSwitch()
	if On:
		TurnOnLight()
	else:
		TurnOffLight()

	add_to_group("Lights")
	visible = true



func  TurnOnLight():
	if get_node_or_null("ceilingLight"):
		$ceilingLight.TurnOn()
		$AudioStreamPlayer3D.volume_db = RandomVolume
		$AudioStreamPlayer3D.pitch_scale = RandomPitchScale
		$AudioStreamPlayer3D.play()
	light_energy = MaxPowerOfLight
	On = true

func  TurnOffLight():
	if get_node_or_null("ceilingLight"):
		$ceilingLight.TurnOff()
		$AudioStreamPlayer3D.stop()
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

