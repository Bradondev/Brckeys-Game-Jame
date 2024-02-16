extends ButtonBase


func _ready():
	super._ready()
	if OS.get_name() == "Web":
		visible = false


func _on_pressed():
	get_tree().quit()
