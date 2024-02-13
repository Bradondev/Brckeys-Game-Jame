extends CharacterBody3D
class_name  Monster



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide()
	
	if velocity.length() > 0:
		# Play walk Animation 
		pass
	
	#make Monster look where its moving
		
