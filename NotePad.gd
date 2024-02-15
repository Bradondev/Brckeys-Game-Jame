extends InterActiveObject


@export var Messeage: Note
@export var ImagePart :Texture2D

func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func InterAct():
	$CanvasLayer.visible = true
	$CanvasLayer/Control/StickyNote/NoteMessage.text = Messeage.Messeage 
	$CanvasLayer/TextureRect.texture = ImagePart


func _on_resume_button_pressed():
	$CanvasLayer.visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	print_debug("hit")

func _on_canvas_layer_visibility_changed():
	if is_visible_in_tree():
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


