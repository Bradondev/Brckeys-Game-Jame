extends Control


@export var  Battery :Texture
var BatteriesInUi 
# Called when the node enters the scene tree for the first time.


func AddBatteryToUi():
	var BatteryUi = TextureRect.new()
	BatteryUi.texture =Battery
	$batteryDisplayer.add_child(BatteryUi)
func DelBatteryUi():
	BatteriesInUi = $batteryDisplayer.get_children() 
	BatteriesInUi[0].queue_free()
