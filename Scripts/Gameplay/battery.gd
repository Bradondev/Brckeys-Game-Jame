extends InterActiveObject


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

	var data = LevelLoader.Load(self)
	if data != null:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func InterAct():
	LevelLoader.GetPlayer().HasBattery = true
	LevelLoader.GetPlayer().AddBattery()
	LevelLoader.Save(self, {"bUsed" : true})
	SoundManager.PlaySFX("res://Audio/Pick Up Battery Sound.mp3", global_position)
	queue_free()
