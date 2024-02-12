extends InterActiveObject


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("PickUpAbleObeject")
	super._ready()


func InterAct():
	Player.PickUpItem(self)
