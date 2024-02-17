extends Control

func _input(event):
	if event.is_action_pressed("Escape"):
		if visible == false:
			if get_tree().paused == false:
				visible = true
		else:
			await get_tree().process_frame
			_on_resume_button_button_up()

func _on_visibility_changed():
	if is_visible_in_tree():
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		if visible == false:
			visible = true




func _on_resume_button_button_up():
	visible = false
	$"../Settings".visible = false
func _exit_tree():
	get_tree().paused = false





