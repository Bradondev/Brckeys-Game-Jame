extends InterActiveObject

@export_color_no_alpha var DeniedColor: Color
@export_color_no_alpha var OpenColor: Color
@export var DoorToUnlock : NodePath

var bIsOpen =false
signal  UnlockDoor

func _ready():
	super._ready()
	var data = LevelLoader.Load(self)
	if data != null:
		Open()

# Called when the node enters the scene tree for the first time.
func InterAct():
	if not bIsOpen:
		if LevelLoader.GetPlayer().Batteries.has("Battery"):
			LevelLoader.GetPlayer().DelBattery()
			Open()
			LevelLoader.Save(self, {"bSet": true})
			SoundManager.PlaySFX("res://Audio/Inject Battery Into Door.mp3", global_position)
		else:
			$PopUp/Description.text = "You need a battery!"
			$PopUp/Description.outline_modulate = DeniedColor
			$Timer.start()


func Open():
	await get_tree().create_timer(.1).timeout
	bIsOpen = true
	print_debug("Opened door")
	$PopUp/Description.text = "Door is opened!"
	$PopUp/Description.outline_modulate = OpenColor
	get_node(DoorToUnlock).UnlockDoor()

func _on_timer_timeout():
	$PopUp.SetLabels()
