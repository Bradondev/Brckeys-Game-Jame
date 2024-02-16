extends Node3D



var master_Bus = AudioServer.get_bus_index("Master")
var music_Bus = AudioServer.get_bus_index("Music")
var sfx_Bus = AudioServer.get_bus_index("SFX")



func _ready():
	$CanvasLayer/Panel/VBoxContainer2/Music2.value = LevelLoader.Music
	$CanvasLayer/Panel/VBoxContainer2/Master2.value = LevelLoader.Master
	$CanvasLayer/Panel/VBoxContainer2/SFX2.value = LevelLoader.SFX
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
