extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	environment = load("res://Lighting/NormalLightingEnvironment.tres")
