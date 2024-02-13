extends State
class_name  MonsterIdle

@export var enemy: CharacterBody3D
@export var move_speed := 10

var  Move_direction :Vector3
var wander_time:float
func randomize_wander():
	
	Move_direction = Vector3(randf_range(-1,1),randf_range(0,0),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func Enter():
	randomize_wander()

func Update(delte:float):
	if wander_time > 0:
		wander_time -=delte
	else:
		randomize_wander()
func  _physics_process(delta:float):
	if enemy:
		enemy.velocity = Move_direction * move_speed
		
	var direction = LevelLoader.GetPlayer().global_position - enemy.global_position
	
	if direction.length() < 20:
		print_debug("chase")
		Transitioned.emit(self,"Chase")
	
