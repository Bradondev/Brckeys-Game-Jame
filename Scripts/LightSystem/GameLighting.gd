extends WorldEnvironment


@export var bUseDarkLighting = false
# Called when the node enters the scene tree for the first time.
func _enter_tree():
	if bUseDarkLighting:
		environment = load("res://Lighting/DarkLightingEnvironment.tres")
	else:
		environment = load("res://Lighting/NormalLightingEnvironment.tres")
