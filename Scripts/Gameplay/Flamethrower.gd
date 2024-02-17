extends Node3D

@export var startTime = .5
@export var fireLength = 1
@export var offTime = .2

func _ready():
	$Timer.wait_time = offTime
	$StartTimer.wait_time = startTime
	$StartTimer.start()

func TurnOn():
	$CPUParticles3D.emitting = true
	$OmniLight3D.visible = true
	$AnimationPlayer.play("active")
	SoundManager.PlaySFX("res://Audio/Flamethrower turn on.mp3", global_position, 11)
	SoundManager.PlaySFX("res://Audio/Flamethrower running (needs fixing).mp3", global_position, 12)
	$Area3D.monitoring = true
	$Timer.wait_time = fireLength
	$Timer.start()

func TurnOff():
	$CPUParticles3D.emitting = false
	$OmniLight3D.visible = false
	$AnimationPlayer.play("idle")
	SoundManager.PlaySFX("res://Audio/Flamethrower turn off.mp3", global_position, 11)
	SoundManager.StopSFX(12)
	$Area3D.monitoring = false
	$Timer.wait_time = offTime
	$Timer.start()

func _on_timer_timeout():
	if $CPUParticles3D.emitting:
		TurnOff()
	else:
		TurnOn()

func _exit_tree():
	SoundManager.StopSFX(12)

func _on_start_timer_timeout():
	$Timer.start()


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		body.TakeDamage()

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		body.TakeDamage()
