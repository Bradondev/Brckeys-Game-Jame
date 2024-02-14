extends CharacterBody3D

signal PickUpItemSignal(Item)
signal JustDied
signal AddBatteryUi
signal DelBatteryUi
const ACCEL = 10
const DEACCEL = 30

const SPEED = 7.0
const SPRINT_MULT = 2
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.06

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var camera
var rotation_helper
var dir = Vector3.ZERO
var flashlight

var Health = 3
var HasScanner =false
var HasBattery = false
var ScannerCharge = 0
var Batteries =[]


func _ready():
	camera = $rotation_helper/Camera3D
	rotation_helper = $rotation_helper
	flashlight = $rotation_helper/Camera3D/flashlight_player

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("Player")
	PlayFade(false)

	var data = LevelLoader.LoadPlayer()
	if data != null:
		if len(data["Batteries"]) != 0:
			Batteries = data["Batteries"]
			emit_signal("AddBatteryUi")
		if data["FlashlightActivated"]:
			flashlight.show()



func PlayFade(bForwards):
	if bForwards:
		$AnimationPlayer.play("Fade")
	else:
		$AnimationPlayer.play_backwards("Fade")
func _input(event):
	# This section controls your player camera. Sensitivity can be changed.
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation
		camera_rot.x = clampf(camera_rot.x, -1.4, 1.4)
		rotation_helper.rotation = camera_rot

	# Release/Grab Mouse for debugging. You can change or replace this.
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Flashlight toggle. Defaults to F on Keyboard.
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F:
			if flashlight.is_visible_in_tree() and not event.echo:
				flashlight.hide()
			elif not event.echo:
				flashlight.show()
			SavePlayer()

func _physics_process(delta):
	var moving = false
	# Add the gravity. Pulls value from project settings.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# This just controls acceleration. Don't touch it.
	var accel
	if dir.dot(velocity) > 0:
		accel = ACCEL
		moving = true
	else:
		accel = DEACCEL
		moving = false


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with a custom keymap depending on your control scheme. These strings default to the arrow keys layout.
	var input_dir = Input.get_vector("Walk_Left", "Walk_Right", "Walk_ForWard", "Walk_BackWard")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * accel * delta
	if Input.is_key_pressed(KEY_SHIFT):
		direction = direction * SPRINT_MULT
	else:
		pass

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func TakeDamage():
		print_debug("Dead")
		emit_signal("JustDied")

		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$AnimationPlayer.play("Death")




func PickUpItem(Item):
	emit_signal("PickUpItemSignal",Item)

func AddBattery():
	Batteries.append("Battery")
	emit_signal("AddBatteryUi")
	SavePlayer()

func DelBattery():
	Batteries.pop_back()
	emit_signal("DelBatteryUi")
	SavePlayer()

func SavePlayer():
	LevelLoader.SavePlayer({
		"Batteries" : Batteries,
		"FlashlightActivated" : flashlight.visible})


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Death":

		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
