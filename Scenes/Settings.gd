extends Node3D

func _ready():
	$CanvasLayer/Panel/VBoxContainer2/Music2.value = LevelLoader.Music
	$CanvasLayer/Panel/VBoxContainer2/Master2.value = LevelLoader.Master
	$CanvasLayer/Panel/VBoxContainer2/SFX2.value = LevelLoader.SFX

func _on_master_2_value_changed(value):
	LevelLoader.SetBusVolume(LevelLoader.master_Bus,value)

func _on_music_2_value_changed(value):
	LevelLoader.SetBusVolume(LevelLoader.music_Bus,value)

func _on_sfx_2_value_changed(value):
	LevelLoader.SetBusVolume(LevelLoader.sfx_Bus,value)

func _on_music_2_drag_ended(_value_changed):
	LevelLoader.SaveSettings()

func _on_master_2_drag_ended(_value_changed):
	LevelLoader.SaveSettings()

func _on_sfx_2_drag_ended(_value_changed):
	LevelLoader.SaveSettings()
