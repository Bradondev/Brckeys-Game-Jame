extends Node3D



func AddItem(Item):
	if Item.name =="Scanner":
		print_debug("found Scanner")
		LevelLoader.GetPlayer().HasScanner = true
		LevelLoader.GetPlayer().ScannerCharge = 3
		return
	if Item.name =="Battery":
		LevelLoader.GetPlayer().HasBattery = true
		return

