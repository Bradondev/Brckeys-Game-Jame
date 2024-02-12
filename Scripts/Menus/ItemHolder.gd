extends Node3D




func AddItem(Item):
	print_debug("Pick Up")
	add_child(Item)
	Item.visible = false
	

