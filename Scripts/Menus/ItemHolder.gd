extends Node3D


var HasScanner =false
var HasBattery = false
var ScannerCharge = 0

func AddItem(Item):
	if Item.name =="Scanner":
		print_debug("found Scanner")
		HasScanner = true
		ScannerCharge = 3
		return
	if Item.name =="Battery":
		HasBattery = true
		return

