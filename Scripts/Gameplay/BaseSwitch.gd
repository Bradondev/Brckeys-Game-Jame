extends InterActiveObject
class_name  Switch
signal Fliped


# Switch needs to be above the lights  in Scene tree in order for it to work
@export var NeedBattery = false
@export_enum("1","2","3","4","5","6","7","8","9","10","11","12","13","14") var Switchlocation: String
@export_color_no_alpha var DeniedColor: Color
@export_color_no_alpha var OpenColor: Color

var Name ="Switch"

var bHasFlipped = false

func _ready():
	add_to_group(Switchlocation)
	super._ready()

	var data = LevelLoader.Load(self)
	if data != null:
		if data["bHasFlipped"]:
			await get_tree().process_frame
			emit_signal("Fliped")
		bHasFlipped = data["bHasFlipped"]
		if bHasFlipped:
			$LightSwitch.TurnOn()
		else:
			$LightSwitch.TurnOff()


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
		bHasFlipped = !bHasFlipped
		LevelLoader.Save(self, {"bHasFlipped" : bHasFlipped})
		if bHasFlipped:
			$LightSwitch.TurnOn()
		else:
			$LightSwitch.TurnOff()
		if bHasFlipped:
			SoundManager.PlaySFX("res://Audio/Light Switch - On.mp3", global_position)
		else:
			SoundManager.PlaySFX("res://Audio/Light Switch - Off.mp3", global_position)




func _on_timer_timeout():
	$PopUp.SetLabels()
