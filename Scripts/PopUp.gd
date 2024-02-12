extends Node3D

@export var  DescriptionTextValue :String
@export var InputTextLabelValue :String
@export var PopHitBox : Node3D

@onready var DescriptionText = $Description
@onready var InputTextLabel = $InputLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	DescriptionText.text = DescriptionTextValue
	InputTextLabel.text = InputTextLabelValue
	SetHitBox()
func FlipVisible():
	if visible:
		visible = false
	elif !visible:
		visible = true


func _on_hit_box_area_entered(area):
	FlipVisible()
	print(area)

func _on_hit_box_area_exited(area):
	FlipVisible()

func SetHitBox():
	$HitBox/CollisionShape3D.shape.size.x = PopHitBox.shape.size.x
	$HitBox/CollisionShape3D.shape.size.z = PopHitBox.shape.size.z
	$HitBox/CollisionShape3D.shape.size.y = PopHitBox.shape.size.y
