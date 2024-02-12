extends InterActiveObject 
class_name  Switch
signal Fliped


@export var NeedBattery = false
@export_enum("1","2","3","4","5","6","7","8","9","10","11","12","13","14") var Switchlocation: String
@export_color_no_alpha var DeniedColor: Color
@export_color_no_alpha var OpenColor: Color

var Name ="Switch"
func _ready():
	add_to_group(Switchlocation)
	super._ready()
	
func InterAct():
	if NeedBattery and LevelLoader.GetPlayer().Batteries.has("Battery"):
		NeedBattery = false
		LevelLoader.GetPlayer().DelBattery()
		$PopUp/Description.text = "Battery entered!"
		$PopUp/Description.outline_modulate = OpenColor
		emit_signal("Fliped")
	elif NeedBattery and !LevelLoader.GetPlayer().Batteries.has("Battery"):
		$PopUp/Description.text = "You need a battery!"
		$PopUp/Description.outline_modulate = DeniedColor
		$Timer.start()
	elif !NeedBattery:
		emit_signal("Fliped")
		




func _on_timer_timeout():
	$PopUp.SetLabels()
