extends  InterActiveObject

@export var bIsOn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	super._ready()
	
func InterAct():
	if bIsOn:
		$PopUp/Description.text = "Turn on"
		bIsOn = false
		$AudioStreamPlayer3D.stop()

	else:
		bIsOn = true
		
		$AudioStreamPlayer3D.play()
		$PopUp/Description.text = "Turn off"
