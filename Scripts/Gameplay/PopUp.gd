extends Node3D

@export var  DescriptionTextValue :String
@export var InputTextLabelValue :String

@onready var DescriptionText = $Description
@onready var InputTextLabel = $InputLabel
@export_color_no_alpha var OutLinecolor: Color
var IsbeingLookedAt = false
var bIsLocked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	SetLabels()

func FlipVisible():
	if bIsLocked:
		visible = false
		return

	if visible:
		visible = false
	elif !visible:
		visible = true

func  _physics_process(delta):
	if bIsLocked:
		visible =false
		return

	if IsbeingLookedAt:
		visible = true
	else:
		visible =false







func SetLabels():
	DescriptionText.text = DescriptionTextValue + "\n" + InputTextLabelValue
	InputTextLabel.text = InputTextLabelValue
	DescriptionText.outline_modulate =OutLinecolor



