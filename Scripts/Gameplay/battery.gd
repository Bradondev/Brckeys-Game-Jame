extends InterActiveObject


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func InterAct():
	LevelLoader.GetPlayer().HasBattery = true
	LevelLoader.GetPlayer().AddBattery()
	queue_free()
