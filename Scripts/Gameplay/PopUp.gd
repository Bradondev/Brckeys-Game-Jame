extends Node3D

@export var  DescriptionTextValue :String
@export var InputTextLabelValue :String
@export var PopHitBox : Node3D

@onready var DescriptionText = $Description
@onready var InputTextLabel = $InputLabel
@export_color_no_alpha var OutLinecolor: Color
var IsbeingLookedAt = false
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	SetLabels()
func FlipVisible():
	if visible:
		visible = false
	elif !visible:
		visible = true
func  _physics_process(delta):
	if IsbeingLookedAt:
		visible = true
	else:
		visible =false
		
		
		
		



func SetLabels():
	DescriptionText.text = DescriptionTextValue
	InputTextLabel.text = InputTextLabelValue
	DescriptionText.outline_modulate =OutLinecolor



