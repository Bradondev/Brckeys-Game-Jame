@tool
extends Node
var camera


func _ready():
	camera = $SubViewport/MirrorCamera
	pass


func _process(delta):
	camera.position = self.position
	camera.rotation_degrees = self.rotation_degrees + Vector3(90, 0, 180)
	pass

