extends Button
class_name ButtonBase

var InTween


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	StartTween()
	connect("visibility_changed", Callable(self, "OnVisChanged"))

func StartTween():
	modulate = Color(0, 0, 0, 0)
	if is_instance_valid(InTween):
		InTween.stop()
	InTween = get_parent().create_tween()
	InTween.tween_property(self, "modulate", Color.WHITE, .2).set_trans(Tween.TRANS_SINE)
	InTween.play()

func OnVisChanged():
	if visible:
		StartTween()
