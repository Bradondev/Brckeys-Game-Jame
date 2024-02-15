extends Node3D


var pulseAmount = 3
var pulseSpeed = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = randf_range(1, 40)
	$Timer.start()

	await get_tree().process_frame
	LevelLoader.GetLevel().connect("SpawnEnemy", Callable(self, "OnEnemySpawned"))


func OnEnemySpawned():
	_on_timer_timeout()
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$AnimationPlayer.speed_scale = randi_range(2, 3)
	pulseAmount = randi_range(1, 8)
	$AnimationPlayer.play("rumble")
	SoundManager.PlaySFX("res://Audio/Light bulb.mp3", global_position, 8)


func _on_animation_player_animation_finished(anim_name):
	if pulseAmount <= 0:
		$Timer.wait_time = randf_range(10, 40)
		$Timer.start()
	else:
		pulseAmount -= 1
		$AnimationPlayer.play("rumble")
		SoundManager.PlaySFX("res://Audio/Light bulb.mp3", global_position, 8)
	pass # Replace with function body.
