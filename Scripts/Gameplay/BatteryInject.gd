extends InterActiveObject

@export_color_no_alpha var DeniedColor: Color
@export_color_no_alpha var OpenColor: Color

var Open =false
signal  UnlockDoor

func _ready():
	super._ready()
# Called when the node enters the scene tree for the first time.
func InterAct():
	if not Open:
		if LevelLoader.GetPlayer().Batteries.has("Battery"):
			LevelLoader.GetPlayer().DelBattery()
			Open = true
			print_debug("Opened door")
			$PopUp/Description.text = "Door is opened!"
			$PopUp/Description.outline_modulate = OpenColor
			emit_signal("UnlockDoor")
		else:
			$PopUp/Description.text = "You need a battery!"
			$PopUp/Description.outline_modulate = DeniedColor
			$Timer.start()


func _on_timer_timeout():
	$PopUp.SetLabels()
