extends Control


var master_Bus = AudioServer.get_bus_index("Master")
var music_Bus = AudioServer.get_bus_index("Music")
var sfx_Bus = AudioServer.get_bus_index("SFX")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
		visible = false




func _ready():
	$ColorRect/Panel/VBoxContainer2/Master2.value = LevelLoader.Master
	$ColorRect/Panel/VBoxContainer2/Music2.value = LevelLoader.Music
	$ColorRect/Panel/VBoxContainer2/SFX2.value = LevelLoader.SFX
func _on_master_2_value_changed(value):
	AudioServer.set_bus_volume_db(master_Bus,value)

	if value == -30:
		AudioServer.set_bus_mute(master_Bus,true)
	else:
		AudioServer.set_bus_mute(master_Bus,false)


func _on_music_2_value_changed(value):
	AudioServer.set_bus_volume_db(music_Bus,value)
	if value == -30:
		AudioServer.set_bus_mute(music_Bus,true)
	else:
		AudioServer.set_bus_mute(music_Bus,false)

func _on_sfx_2_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_Bus,value)
	if value == -30:
		AudioServer.set_bus_mute(sfx_Bus,true)
	else:
		AudioServer.set_bus_mute(sfx_Bus,false)




func _on_music_2_drag_ended(value_changed):
	LevelLoader.SaveSettings()


func _on_master_2_drag_ended(value_changed):
	LevelLoader.SaveSettings()


func _on_sfx_2_drag_ended(value_changed):
	LevelLoader.SaveSettings()
